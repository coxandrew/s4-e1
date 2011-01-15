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

  def status
    column_widths = [10, 30, 10, 8]

    print_project_status_header(projects, column_widths)
    projects.each { |project| print_project_line(project, column_widths) }
  end

  private

  def next_deadline(project)
    # response = api_request("#{API_BASE_URI}projects/#{project[:id]}/iterations")
    #     puts response
    # return response.xpath("2011-01-20"
    "2011-01-20"
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
    @output.print next_deadline(project).ljust(column_widths[3])
    @output.puts ""
  end
end
