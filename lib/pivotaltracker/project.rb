module PivotalTracker
  class Project
    attr_reader :id, :name, :velocity

    def initialize(attributes)
      @connection = Connection.new
      @id         = attributes["id"]
      @name       = attributes["name"]
      @velocity   = attributes["current_velocity"]
    end

    def self.all
      projects = Connection.new.request("/projects").parsed_response["projects"]
      projects.collect { |attributes| Project.new(attributes) }
    end

    def releases
      @connection.request("/projects/#{@id}/stories",
        :filter => "type:release").parsed_response["stories"]
    end

    def next_milestone
      releases.each do |release|
        if release["deadline"]
          return release if Date.parse(release["deadline"].to_s) >= Date.today
        end
      end
    end
  end
end