# the following was taken from a gist by Jose Valim on token authentication here:
# https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
#
# We could make the authentication mechanism above a bit more safe
# by requiring a token **AND** an e-mail for token authentication.
# The code in the model looks the same, we just need to slightly
# change the controller:

# Main controller
class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!

  private

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end
end

