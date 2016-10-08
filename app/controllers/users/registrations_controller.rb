class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    super
    session['facebook_data'] = {}
  end
end
