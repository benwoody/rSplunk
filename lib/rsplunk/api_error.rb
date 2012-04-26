module Rsplunk
  class APIError < StandardError

    attr_reader :code
    attr_reader :response

    def initialize(error, response)
      @code   = error.status
      @response = response
    end

    # Return the HTTP code and response
    # (404):Unknown sid
    def message
      "(#{@code}):#{@response["response"]["messages"]["msg"]}"
    end
    alias :to_s :message
  end
end
