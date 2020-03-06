module CCA
  class Configuration
    attr_accessor :api_key,
                  :url,
                  :sandbox

    def incomplete?
      [:api_key, :url].any? { |e| self.send(e).nil? }
    end

  end
end
