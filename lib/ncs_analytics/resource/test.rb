module NcsAnalytics
  class Test < NcsAnalytics::Resource
    def anon
      get(:anon)
    end

    def what_is_my_ip
      get(:whatismyip)
    end

    alias ip what_is_my_ip

    def auth
      get(:auth)
    end
  end
end
