# Service object that connects to the openMRS rest API
class OpenmrsClient
  def initialize
    @conn = Faraday.new(url: ENV["OPENMRS_BASE_URL"]) do |faraday|
      f.request :retry, max: 3, interval: 0.1, backoff_factor: 2 # retry_logic
      f.response :raise_error                                    # raise faraday exceptions
      f.adapter Faraday.default_adapter
    end
  end

  # Fetches patients from openMRS API
  def fetch_patients
    response = @conn.get("http://openmrs.org/api/v1/patients") do |req|
      req.headers["Accept"] = "application/json"
      req.headers["Authorization"] = "Basic #{ENV['OPENMRS_BASIC_AUTH']}"
    end

    JSON.parse(response.body)
  rescue Faraday::Error => e
    # standardized error response for external api failure
    {error: e.message, code: 502}
  end
end