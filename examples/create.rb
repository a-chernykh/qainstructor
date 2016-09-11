require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'fileutils'
require 'erb'
require 'optparse'

Dotenv.load '../env/common.env'

options = {environment: 'development'}
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby create.rb [options]'

  opts.on('-eENRIVONMENT', '--environment=ENVIRONMENT', 'Set environment (developmenr or production)') do |e|
    options[:environment] = e
  end

  opts.on('-c', '--compile', 'Combine examples and template together in output folder') do |c|
    options[:compile] = true
  end

  opts.on('-a', '--archive', 'Create ZIP archives and copy them to engine') do |a|
    options[:archive] = true
  end

  opts.on('-t', '--test', 'Test example by running cucumber command') do |t|
    options[:test] = true
  end
end.parse!

Dotenv.load "../env/#{options[:environment]}.env"
raise 'Env variable SAMPLE_APP_HOST is not defined' unless ENV['SAMPLE_APP_HOST']

output_dir = 'output'
FileUtils.mkdir_p output_dir

template_dir = 'template'

if options[:compile]
  puts 'Compiling'
  Dir['*/*'].each do |file|
    course, example = file.split '/'

    if example =~ /\A\d+\z/
      example_name = "#{course}-example#{example}"
      example_dir = File.join output_dir, example_name

  #    FileUtils.rm_rf example_dir
      FileUtils.mkdir_p example_dir

      `cp -rf #{course}/#{template_dir}/* #{example_dir}/` if Dir.exists?(File.join(file, 'features'))
      `cp -rf #{file}/* #{example_dir}/`

      Dir[File.join(example_dir, '**', '*.erb')].each do |erb|
        input = erb
        output = erb.gsub '.erb', ''

        erb = ERB.new(File.read(input))
        result = erb.result(binding)

        File.open(output, 'w') { |f| f.write result }
        FileUtils.rm_f input
      end
    end
  end
end

if options[:archive]
  puts 'Archiving'
  system("rm -f #{output_dir}/*.zip")

  Dir[File.join(output_dir, '*')].each do |example|
    name = example.split('/').last

    Dir.chdir(example) do
      puts "Archiving #{example}"
      cmds = []
      if options[:test] && File.exist?("Gemfile")
        cmds += ['bundle install > /dev/null', 'bundle exec cucumber > /dev/null']
      end
      cmds += [ "zip -X -r ../#{name}.zip ." ]
      cmds.each do |cmd|
        puts "Running `#{cmd}`"
        Bundler.with_clean_env do
          raise "Failing example: #{example}" unless system(cmd)
        end
      end
    end
  end

  dest_dir = "../engine/public/downloads/#{options[:environment]}/WEB1/"
  puts "Copy to: #{dest_dir}"
  system("cp -f #{output_dir}/*.zip #{dest_dir}")
end
