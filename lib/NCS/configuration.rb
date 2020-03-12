module NCS
  class Configuration
    attr_accessor :api_key,
                  :uri,
                  :debug

    def incomplete?
      %i[api_key uri].any? {|e| send(e).nil? }
    end

    def to_s
      to_h.to_s
    end

    def to_h
      {
        api_key: api_key,
        uri: uri,
        debug: debug
      }
    end
  end
end
