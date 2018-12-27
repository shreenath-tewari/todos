class AuthenticateUser
  # set parameters
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if user
      JsonWebToken.encode(user_id: user.id)
    end
  end

  private

  attr_reader :email, :password

  def user
    # find user
    user = User.find_by(email: email)

    # authenticate user
    if user && user.authenticate(password)
      return user
    end

    # if user is not authenticated
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

end