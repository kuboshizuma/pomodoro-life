class Users::SessionsController < Devise::SessionsController
  def destroy
    super
    session['facebook_data'] = {}
  end
end
