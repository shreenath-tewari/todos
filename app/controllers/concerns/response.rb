module Response
  # helper function for controllers
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end