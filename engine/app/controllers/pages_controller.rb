class PagesController < ApplicationController
  PAGES = %w(terms privacy thanks)

  def show
    if PAGES.include?(params[:page])
      render template: "pages/#{params[:page]}"
    else
      render text: 'Page not found', status: :not_found
    end
  end
end
