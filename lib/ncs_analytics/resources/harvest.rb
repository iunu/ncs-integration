module NcsAnalytics
  module Resources
    class Harvest < NcsAnalytics::Resource
      def active
        by_state(:active)
      end

      def inactive
        by_state(:inactive)
      end

      def onhold
        by_state(:onhold)
      end

      def create(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:create, payload)
      end

      def create_package(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:createpackages, payload)
      end

      def update(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:update, payload)
      end

      def finish(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:finish, payload)
      end

      def unfinish(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:unfinish, payload)
      end

      def remove_waste(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:removewaste, payload)
      end

      private

      def by_state(state)
        get(state)
      end
    end
  end
end
