module Verification
  def expect_feature_to_include(content)
    file = Dir.glob('./**/*.feature')[0]
    expect(File.read(file).downcase).to include content.downcase
  end

  def expect_steps_to_include(content)
    file = Dir.glob('./**/*_steps.rb')[0]
    expect(File.read(file).downcase).to include content.downcase
  end
end
World(Verification)
