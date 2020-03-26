module NcsAnalytics
  module Resources
    class Package < NcsAnalytics::Resource
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

      def create_plantings(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post('create/plantings', payload)
      end

      def change_item(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post('change/item', payload)
      end

      def remediate(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:remediate, payload)
      end

      def adjust(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:adjust, payload)
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

      private

      def by_state(state)
        get(state)
      end
    end
  end
end
