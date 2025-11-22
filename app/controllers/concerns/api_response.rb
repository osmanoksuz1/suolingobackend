module ApiResponse
  extend ActiveSupport::Concern

  def render_json_response(status:, data: nil, message: nil, http_status: :ok)
    response = {
      status: status,
      message: message,
      timestamp: Time.current.iso8601
    }
    response[:data] = data if data.present?

    render json: response, status: http_status
  end
end
