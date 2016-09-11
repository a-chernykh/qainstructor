class DiscourseController < ApplicationController
  before_action :authenticate_user!

  def sso
    @sso = Discourse::SingleSignOn.parse(request.query_string, ENV['DISCOURSE_SSO_SECRET'])
    @sso.email = current_user.email
    @sso.name = current_user.name
    @sso.external_id = current_user.id
    @sso.sso_secret = ENV['DISCOURSE_SSO_SECRET']

    redirect_to @sso.to_url("#{ENV['DISCOURSE_URL']}/session/sso_login")
  end
end
