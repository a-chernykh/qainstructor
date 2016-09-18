class LandingController < ApplicationController
  layout false

  def show
    landing_template = ab_test(:landing_design, 'show', 'show.new')
    render template: File.join('landing', landing_template)
  end
end
