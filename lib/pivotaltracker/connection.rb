require 'httparty'

module PivotalTracker
  class Connection
    include HTTParty

    base_uri "www.pivotaltracker.com/services/v3"
    format :xml

    def initialize(token = "6f23b318f92337792996c9d4e1fb6ed7")
      @token = token
    end

    def request(path, query = {})
      Connection.get(path,
        :headers => { "X-TrackerToken" => @token },
        :query => query
      )
    end
  end
end