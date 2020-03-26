module NcsAnalytics
  module Resources
    class Room < NcsAnalytics::Resource
      def all
        get(:all)
      end

      def create(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:create, payload)
      end

      def update(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:update, payload)
      end
    end
  end
end
