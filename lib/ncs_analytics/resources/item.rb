module NcsAnalytics
  module Resources
    class Item < NcsAnalytics::Resource
      def all
        get(:all)
      end

      def categories
        get(:categories)
      end

      def create(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:create, payload)
      end

      def create_categories(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post('create/categories', payload)
      end

      def update(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post(:update, payload)
      end

      def update_categories(payload)
        # TODO: Validate the payload
        payload = [payload] unless payload.is_a?(Array)
        post('update/categories', payload)
      end
    end
  end
end
