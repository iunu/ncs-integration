require 'json'
require 'httparty'
require 'hash_validator'

require 'ncs_analytics/errors'

module NcsAnalytics
  class Base
    include HTTParty

    SCHEMA = {}
    headers 'content-type': 'application/json'

    attr_reader :debug,
                :response,
                :api_key,
                :uri,
                :resource

    def initialize(resource = nil, validation_hash = nil, opts = {}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      @resource = resource || "#{self.class.name.split('::').last.downcase}s".to_sym
      @debug    = opts[:debug] || NcsAnalytics.configuration.debug || false
      @api_key  = opts[:api_key] || NcsAnalytics.configuration.api_key
      @uri      = opts[:uri] || NcsAnalytics.configuration.uri

      sign_in

      @validation_hash = validation_hash || self.class::SCHEMA || {}
      self.class.base_uri @uri
      self.class.headers Authorization: @api_key
    end

    def get(resource_id)
      request(resource_id)
    end

    def post(resource_id, body)
      request(resource_id, :post, body.to_json)
    end

    protected

    def valid?(payload)
      if payload.is_a?(Array)
        payload.each {|data| validate(data) }
      else
        validate(payload)
      end

      true
    end

    private

    def sign_in
      raise Errors::MissingConfiguration if configuration.incomplete?
    end

    def configuration
      NcsAnalytics.configuration
    end

    def validate(payload)
      validator = HashValidator.validate(payload, @validation_hash)
      p validator.errors
      raise Errors::InvalidPayload, "Invalid payload provided: #{validator.errors}" unless validator.valid?
    end

    def request(path = '', verb = :get, payload = '')
      puts "[#{verb.uppercase}] #{@resource}: #{path}" if @debug

      @response = self.class.send(verb, "/pos/#{@resource}/v1/#{path}", body: payload)

      if @debug
        puts @response.response.code
        puts @response.headers
        puts @response.body
      end

      raise_request_errors
      @response.body
    end

    def raise_request_errors # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      return if @response.success?

      raise Errors::BadRequest, "An error has occurred while executing your request. #{Errors.parse_request_errors(response: @response)}" if @response.bad_request? # rubocop:disable Layout/LineLength

      raise Errors::Unauthorized, 'Invalid or no authentication provided.' if @response.unauthorized?

      raise Errors::Forbidden, 'The authenticated user does not have access to the requested resource.' if @response.forbidden? # rubocop:disable Layout/LineLength

      raise Errors::NotFound, 'The requested resource could not be found (incorrect or invalid URI).' if @response.not_found? # rubocop:disable Layout/LineLength

      raise Errors::TooManyRequests, 'The limit of API calls allowed has been exceeded. Please pace the usage rate of the API more apart.' if @response.too_many_requests? # rubocop:disable Layout/LineLength

      raise Errors::InternalServerError, 'An error has occurred while executing your request.' if @response.server_error? # rubocop:disable Layout/LineLength
    end
  end
end
