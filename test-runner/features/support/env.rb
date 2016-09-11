require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

OUTPUT_DIR = 'features/user/result'
FileUtils.mkdir_p OUTPUT_DIR

# $step_counter = 0
AfterStep do |scenario|
  # screenshot_path = File.join(OUTPUT_DIR, "screenshot-#{$step_counter}.png")
  # @browser.save_screenshot screenshot_path
  # embed screenshot_path, "image/png", "SCREENSHOT"
  # $step_counter += 1
end

require 'stringio'
module Kernel
  def puts(*args)
    $puts_capture ||= StringIO.new
    $puts_capture.puts(args)
    $stdout.puts(args)
  end
end
