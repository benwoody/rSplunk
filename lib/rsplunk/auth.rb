module Rsplunk

  class Auth
    # Create a Splunk session
    def initialize(user, pass)
      @user = user
      @pass = pass
      session_token
    end

    attr_accessor :user, :pass

    # Grab token with username and password
    def create_token
      doc = Hpricot(Rsplunk.splunk_ssl_post_request("/services/auth/login",
                                                          "username=#{@user}&password=#{@pass}"))
      (doc/"//sessionkey").inner_html
    end

    # Returns the session token

    def session_token
      $session_token = create_token
    end

  end

end
