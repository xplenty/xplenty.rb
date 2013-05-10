module Xplenty
  class API
    module Errors
      class Error < StandardError; end

      class ErrorWithResponse < Error
        attr_reader :response

        def initialize(message, response)
          super message
          @response = response
        end
      end

      class RequestFailed < ErrorWithResponse; end
      class NotModified < ErrorWithResponse; end
      class BadRequest < ErrorWithResponse; end
      class Unauthorized < ErrorWithResponse; end
      class PaymentRequired < ErrorWithResponse; end
      class Forbidden < ErrorWithResponse; end
      class NotFound < ErrorWithResponse; end
      class NotAcceptable < ErrorWithResponse; end
      class UnsupportedMediaType < ErrorWithResponse; end
      class UnprocessableEntity < ErrorWithResponse; end
      class TooManyRequests < ErrorWithResponse; end
      class InternalServerError < ErrorWithResponse; end
      class BadGateway < ErrorWithResponse; end
      class ServiceUnavailable < ErrorWithResponse; end

    end
  end
end
