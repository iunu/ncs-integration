module NcsAnalytics
  class Plant < NcsAnalytics::Base
    def all
      by_state(:all)
    end

    def find(id = nil)
      raise Errors::BadRequest, 'A plant ID is required' unless id

      get(id)
    end

    def vegetative
      by_state(:vegetative)
    end

    def flowering
      by_state(:flowering)
    end

    def create(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post('create/plantings', payload)
    end

    def destroy(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:destroyplants, payload)
    end

    def change_growth_phases(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:changegrowthphases, payload)
    end

    def move(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:moveplants, payload)
    end

    def manicure(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:manicureplants, payload)
    end

    def harvest(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:harvestplants, payload)
    end

    private

    def by_state(state)
      get(state)
    end
  end
end
