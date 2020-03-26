module NcsAnalytics
  module Resources
    class Transfer < NcsAnalytics::Resource
      def all_incoming
        get_by_state(:incoming)
      end

      def all_outgoing
        get_by_state(:outgoing)
      end

      def all_rejected
        get_by_state(:rejected)
      end

      def create_incoming(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post_by_state(:incoming, payload)
      end

      def create_outgoing(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post_by_state(:outgoing, payload)
      end

      def create_rejected(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post_by_state(:rejected, payload)
      end

      private

      def get_by_state(state)
        get(state)
      end

      def post_by_state(state, payload)
        post(state, payload)
      end
    end
  end
end
