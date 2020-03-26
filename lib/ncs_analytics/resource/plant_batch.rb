module NcsAnalytics
  class PlantBatch < NcsAnalytics::Resource
    RESOURCE_NAME = "#{name.split('::').last.downcase}es".to_sym

    def find(id = nil)
      raise Errors::BadRequest, 'A plant ID is required' unless id

      get("plantid/#{id}")
    end

    def active
      by_state(:active)
    end

    def inactive
      by_state(:inactive)
    end

    def create(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:createplantings, payload)
    end

    def create_packages(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:createpackages, payload)
    end

    def destroy(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:destroy, payload)
    end

    def change_growth_phase(payload)
      # TODO: Validate the payload
      payload = [payload] unless payload.is_a?(Array)
      post(:changegrowthphase, payload)
    end

    private

    def by_state(state)
      get(state)
    end
  end
end
