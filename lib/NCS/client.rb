require_relative 'model.rb'

require 'net/http'
require 'uri'
require 'httparty'

# NCS module
module NCS
  include Model
  include Constants
  include Errors

  # Client class
  class Client
    include HTTParty
    headers 'Content-Type': 'application/json'

    attr_accessor :debug,
                  :response,
                  :api_key,
                  :parsed_response,
                  :uri

    def initialize(opts = {})
      @debug = opts[:debug]
      @api_key = opts[:api_key]
      @uri = opts[:uri]
      sign_in
    end

    def api_get(url)
      puts "in api_get: #{@uri}#{url}" if @debug
      @response = self.class.get("#{@uri}#{url}",
                                 headers: { Authorization: "Bearer #{@api_key}" })

      if debug
        puts @response.response.code
        puts @response.headers
        puts @response.body
      end

      raise_request_errors
      JSON.parse(@response.body)
    end

    def api_post(url, body)
      puts "in api_post #{@uri}#{url}" if @debug
      @response = self.class.post("#{@uri}#{url}",
                                  headers: { Authorization: "Bearer #{@api_key}" },
                                  body: body)

      if debug
        puts @response.response.code
        puts @response.headers
        puts @response.body
      end

      raise_request_errors
      JSON.parse(@response.body)
    end

    def api_delete(url, options = {})
      option[:Authorization] = api_key

      puts "\nNCS API Request debug\nclient.delete('#{url}', #{options})\n########################\n" if debug

      @response = self.class.get(url, options)
      raise_request_errors

      puts "\nNCS API Response debug\n#{response.to_s[0..360]}\n[200 OK]\n########################\n" if debug

      @response
    end

    def api_put(url, options = {})
      option[:Authorization] = api_key

      puts "\nNCS API Request debug\nclient.put('#{url}', #{options})\n########################\n" if debug

      @response = self.class.get(url, options)
      raise_request_errors

      puts "\nNCS API Response debug\n#{response.to_s[0..360]}\n[200 OK]\n########################\n" if debug

      @response
    end

    def get(resource, resource_id)
      api_get("/pos/#{resource}/v1/#{resource_id}")
    end

    def post(resource, resource_id, resources)
      api_post("/pos/#{resource}/v1/#{resource_id}", resources)
    end

    #----- ROOMS
    #
    def room_get_all
      get(:rooms, :all)
    end

    def room_create(room)
      validate_model(room, [:name])
      post(:rooms, :create, JSON.generate([room]))
    end

    def room_update(room)
      validate_model(room, %w[id name])
      post(:rooms, :update, JSON.generate([room]))
    end

    #----- STRAINS
    #
    def strain_create(strain)
      validate_model(strain, ['name'], extract_keys(ROOM_MODEL))
      post(:strains, :create, JSON.generate([strain]))
    end

    def strain_update(strain)
      validate_model(strain, %w[name id], extract_keys(ROOM_MODEL))
      post(:strains, :update, JSON.generate([strain]))
    end

    def strain_get_all
      get(:strains, :all)
    end

    #----- ITEMS and ITEM CATEGORIES
    #
    def item_category_create(category)
      validate_model(category, [], extract_keys(ITEM_CATEGORY_MODEL))
      post(:items, :createcategories, JSON.generate([category]))
    end

    def item_category_update(category)
      validate_model(category, [], extract_keys(ITEM_CATEGORY_MODEL))
      post(:items, :updatecategories, JSON.generate([category]))
    end

    def item_category_get_all
      get(:items, :categories)
    end

    def item_create(item)
      validate_model(item, [], extract_keys(ITEM_MODEL))
      post(:items, :create, JSON.generate([item]))
    end

    def item_update
      validate_model(item, [], extract_keys(ITEM_MODEL))
      post(:items, :update, JSON.generate([item]))
    end

    def item_get_all
      get(:items, :all)
    end

    #----- PLANT BATCHES
    #
    def plant_batches_get_active
      get(:plantbatches, :active)
    end

    def plant_batches_get_inactive
      get(:plantbatches, :active)
    end

    def plant_batches_get_by_id(id)
      get(:plantbatches, "plantid/#{id}")
    end

    def plant_batches_create_planting(planting)
      validate_model(planting, [], extract_keys(PLANT_PACKAGE_MODEL))
      post(:plantbatches, :createplantings, JSON.generate([planting]))
    end

    def plant_batches_create_package(package)
      validate_model(package, [], extract_keys(PLANT_PACKAGE_MODEL))
      post(:plantbatches, :createpackages, JSON.generate([package]))
    end

    def plant_batches_destroy(plantbatch)
      validate_model(planting, [], extract_keys(PLANT_PACKAGE_MODEL))
      post(:plantbatches, :destroy, JSON.generate([plantbatch]))
    end

    def plant_batches_change_growth_phase(plantbatch)
      validate_model(planting, [], extract_keys(PLANT_PACKAGE_MODEL))
      post(:plantbatches, :changegrowthphase, JSON.generate([plantbatch]))
    end

    #----- PLANTS
    #
    def plants_get_all
      get(:plants, :all)
    end

    def plants_get_vegetative
      get(:plants, :vegetative)
    end

    def plants_get_flowering
      get(:plants, :flowering)
    end

    def plants_get_by_id(id)
      get(:plants, id.to_s)
    end

    def plants_create_planting(planting)
      post(:plants, 'create/plantings', JSON.generate([planting]))
    end

    def plant_destroy_plant(planting)
      post(:plants, :destroyplants, JSON.generate([planting]))
    end

    def plant_change_growth_phases(planting)
      post(:plants, :changegrowthphases, JSON.generate([planting]))
    end

    def plants_move_plant(planting)
      post(:plants, :moveplants, JSON.generate([planting]))
    end

    def plant_manicure_plant(planting)
      post(:plants, :manicureplants, JSON.generate([planting]))
    end

    def plant_harvest_plant(planting)
      post(:plants, :harvestplants, JSON.generate([planting]))
    end

    #----- HARVESTS
    #
    def harvest_get_active
      get(:harvests, :active)
    end

    def harvest_get_inactive
      get(:harvests, :inactive)
    end

    def harvest_get_onhold
      get(:harvests, :onhold)
    end

    def harvest_create_harvest(harvest)
      post(:harvests, :create, JSON.generate([harvest]))
    end

    def harvest_create_package(package)
      post(:harvests, :createpackages, JSON.generate([package]))
    end

    def harvest_update(harvest)
      post(:harvests, :update, JSON.generate([harvest]))
    end

    def harvest_finish(harvest)
      # This is probably not good. Needs to extract id from harvest and manually set finish date?
      post(:harvests, :finish, JSON.generate([harvest]))
    end

    def harvest_unfinish(harvest)
      # this is probably not good; needs to extract id and only send that
      post(:harvests, :unfinish, JSON.generate([harvest]))
    end

    def harvest_remove_waste(harvest)
      post(:harvests, :removewaste, JSON.generate([harvest]))
    end

    #----- PACKAGES
    #
    def package_get_active
      get(:packages, :active)
    end

    def package_get_inactive
      get(:packages, :inactive)
    end

    def package_get_onhold
      get(:packages, :onhold)
    end

    def package_create_package(package)
      post(:packages, :create, JSON.generate([package]))
    end

    def package_create_planting(planting)
      post(:packages, 'create/plantings', JSON.generate([planting]))
    end

    def package_change_item(item)
      post(:packages, 'change/item', JSON.generate([item]))
    end

    def package_remediate(package)
      post(:packages, :remediate, JSON.generate([package]))
    end

    def package_adjust(package)
      post(:packages, :adjust, JSON.generate([package]))
    end

    def package_finish(package)
      post(:packages, :finish, JSON.generate([package]))
    end

    def package_unfinish(package)
      post(:packages, :unfinish, JSON.generate([package]))
    end

    #----- SALES
    #
    def sales_get_all
      get(:sales, :receipts)
    end

    def sales_create(sale)
      post(:sales, :receipts, JSON.generate([sale]))
    end

    #----- TRANSFERS
    #
    def transfers_create(type, transfer)
      post(:transfers, type, JSON.generate([transfer]))
    end

    def transfers_get(type)
      get(:transfers, type)
    end

    def transfers_create_incoming(transfer)
      transfers_create(:incoming, transfer)
    end

    def transfers_get_incoming
      transfers_get(:incoming)
    end

    def transfers_create_outgoing(transfer)
      transfers_create(:outgoing, transfer)
    end

    def transfers_get_outgoing
      transfers_get(:outgoing)
    end

    def transfers_create_rejected(transfer)
      transfers_create(:rejected, transfer)
    end

    def transfers_get_rejected
      transfers_get(:rejected)
    end

    private

    def validate_model(data, requires = [], optional = [])
      # validates that the data DEFINITELY contains keys in "requires", and it's okay if it contains the
      # keys in "optional" but other keys generate errors or warnings.
      require_failures = []
      requires.each {|k| require_failures.push(k) unless data.key?(k) }

      raise Exception, "Required fields missing in call: #{require_failures}" unless require_failures.empty?

      # now we need to validate that there aren't any key values NOT contained in all_names
      all_names = requires.concat(optional)
      key_failures = []
      data.each_key {|k| key_failures.push(k) unless all_names.include? k }

      raise Exception, "Data contains prohibited fields: #{key_failures}" unless key_failures.empty?
    end

    def sign_in
      raise Errors::MissingConfiguration if configuration.incomplete?

      true
    end

    def configuration
      NCS.configuration
    end

    def raise_request_errors # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      return if @response.success?

      raise Errors::BadRequest, "An error has occurred while executing your request. #{NCS::Errors.parse_request_errors(response: response)}" if @response.bad_request? # rubocop:disable Layout/LineLength

      raise Errors::Unauthorized, 'Invalid or no authentication provided.' if @response.unauthorized?

      raise Errors::Forbidden, 'The authenticated user does not have access to the requested resource.' if @response.forbidden? # rubocop:disable Layout/LineLength

      raise Errors::NotFound, 'The requested resource could not be found (incorrect or invalid URI).' if @response.not_found? # rubocop:disable Layout/LineLength

      raise Errors::TooManyRequests, 'The limit of API calls allowed has been exceeded. Please pace the usage rate of the API more apart.' if @response.too_many_requests? # rubocop:disable Layout/LineLength

      raise Errors::InternalServerError, 'An error has occurred while executing your request.' if @response.server_error? # rubocop:disable Layout/LineLength
    end
  end
end
