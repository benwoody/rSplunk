module Rsplunk
  class APIError < StandardError

    attr_reader :code
    attr_reader :response

    def initialize(error, response)
      @code   = error.status
      @response = response
    end

    def message
      "(#{@code}):#{@response}"
    end
    alias :to_s :message
  end
end
