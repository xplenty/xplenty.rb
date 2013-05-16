require "base64"
require "excon"
require "securerandom"
require "uri"
require "zlib"

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
  $LOAD_PATH.unshift(__LIB_DIR__)
end

require "xplenty/api/vendor/okjson"

require "xplenty/api/errors"
require "xplenty/api/mock"
require "xplenty/api/version"

require "xplenty/api/jobs"
require "xplenty/api/cluster_plans"
require "xplenty/api/clusters"
require "xplenty/api/watchers"

srand

module Xplenty
  class API

    HEADERS = {
      'Accept' 			=> 'application/vnd.xplenty+json',
			'User-Agent'  => "xplenty-rb/#{Xplenty::API::VERSION}",
    }

    OPTIONS = {
      :headers  => {},
      :host     => 'api.xplenty.com',
      :nonblock => false,
      :scheme   => 'https'
    }

    def initialize(options={})
      options = OPTIONS.merge(options)

      @api_key = options.delete(:api_key) || ENV['XPLENTY_API_KEY']
      @account_id = options.delete(:account_id) || ENV['XPLENTY_ACCOUNT_ID']
			@version = options.delete(:version)
			@mime_type = "application/vnd.xplenty+json"
			if @version && @version.is_a?(Fixnum)
				@mime_type = @mime_type << "; version=#{@version}"
			end
      user_name = "#{@api_key}"
      options[:headers] = HEADERS.merge({
        'Authorization' => "Basic #{Base64.encode64(user_name).gsub("\n", '')}",
				'Accept'        => @mime_type
      }).merge(options[:headers])

      @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", options)
    end

    def request(params, &block)
      begin
        response = @connection.request(params, &block)
      rescue Excon::Errors::HTTPStatusError => error
        klass = case error.response.status
          when 400 then Xplenty::API::Errors::BadRequest
          when 401 then Xplenty::API::Errors::Unauthorized
          when 402 then Xplenty::API::Errors::PaymentRequired
          when 403 then Xplenty::API::Errors::Forbidden
          when 404 then Xplenty::API::Errors::NotFound
          when 406 then Xplenty::API::Errors::NotAcceptable
          when 415 then Xplenty::API::Errors::UnsupportedMediaType
          when 422 then Xplenty::API::Errors::UnprocessableEntity
          when 429 then Xplenty::API::Errors::TooManyRequests
          when 500 then Xplenty::API::Errors::RequestFailed
          when 502 then Xplenty::API::Errors::BadGateway
          when 503 then Xplenty::API::Errors::ServiceUnavailable
          else Xplenty::API::Errors::ErrorWithResponse
        end

        reerror = klass.new(error.message, error.response)
        reerror.set_backtrace(error.backtrace)
        raise(reerror)
      end

      if response.body && !response.body.empty?
        if response.headers['Content-Encoding'] == 'gzip'
          response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
        end
        begin
          response.body = Xplenty::API::OkJson.decode(response.body)
        #rescue
          # leave non-JSON body as is
        end
      end

      # reset (non-persistent) connection
      @connection.reset

      response
    end

    private

    def account_id
      @account_id
    end

  end
end
