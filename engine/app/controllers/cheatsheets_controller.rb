class CheatsheetsController < ApplicationController
  include AuthorizeCourse

  layout 'cheatsheet'

  def show
    @cheatsheet = @course.cheatsheets.where(code: params[:code]).first!
    authorize(@cheatsheet)
    render File.join('cheatsheets', @course.code.downcase, @cheatsheet.code)
  end
end
