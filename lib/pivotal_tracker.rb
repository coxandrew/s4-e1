require 'nokogiri'
require 'httparty'

class PivotalTracker
  include HTTParty

  base_uri "www.pivotaltracker.com/services/v3"
  format :xml

  def initialize(output)
    @output = output
  end

  def api_request(path, query = {})
    PivotalTracker.get(path,
      :headers => {
        "X-TrackerToken" => "6f23b318f92337792996c9d4e1fb6ed7"
      },
      :query => query
    )
  end

  def projects
    api_request("/projects").parsed_response["projects"]
  end

  def releases_for_project(project)
    api_request("/projects/#{project["id"]}/stories",
      :filter => "type:release").parsed_response["stories"]
  end

  def status
    column_widths = [10, 30, 10, 8]

    print_project_status_header(projects, column_widths)
    projects.each { |project| print_project_line(project, column_widths) }
  end

  private

  def next_deadline_for_project(project)
    releases_for_project(project).each do |release|
      if release["deadline"]
        return release if Date.parse(release["deadline"].to_s) >= Date.today
      end
    end
  end

  def print_project_status_header(projects, column_widths)
    @output.puts ""
    @output.print "id".ljust(column_widths[0])
    @output.print "project".ljust(column_widths[1])
    @output.print "velocity".ljust(column_widths[2])
    @output.print "next deadline".ljust(column_widths[3])
    @output.puts ""
    60.times { |num| @output.print "-" }

    @output.puts ""
  end

  def print_project_line(project, column_widths)
    @output.print project["id"].ljust(column_widths[0])
    @output.print project["name"].ljust(column_widths[1])
    @output.print project["current_velocity"].ljust(column_widths[2])

    next_deadline = next_deadline_for_project(project)
    formatted_deadline = Date.parse(next_deadline["deadline"].to_s).strftime("%Y-%m-%d")
    @output.print "#{formatted_deadline} (#{next_deadline["deadline"]})".ljust(column_widths[3])

    @output.puts ""
  end
end
