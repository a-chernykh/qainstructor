module ApplicationHelper
  def price_in_dollars(price)
    price / 100.to_f
  end

  def example_output_path(chapter:, example:)
    code = chapter.course.code
    "/output/#{code}/#{code}-example#{example}.html"
  end

  def sample_app_url(name)
    "http://#{name}.#{ENV['SAMPLE_APP_HOST']}"
  end
end
