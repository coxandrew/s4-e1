require 'nokogiri'
require 'net/http'
require 'uri'

class PivotalTracker
  API_BASE_URI = "http://www.pivotaltracker.com/services/v3/"
  TOKEN        = '6f23b318f92337792996c9d4e1fb6ed7'

  def initialize(output)
    @output = output
  end

  def status
    response = api_request("#{API_BASE_URI}projects")

    projects = []
    response.xpath('projects/project').each do |project|
      projects << {
        :id               => project.xpath('id').text,
        :name             => project.xpath('name').text,
        :iteration_length => project.xpath('iteration_length').text,
        :current_velocity => project.xpath('current_velocity').text
      }
    end

    column_widths = [10, 30, 10]
    print_project_status_header(projects, column_widths)
    projects.each { |project| print_project_line(project, column_widths) }
  end

  private

  def print_project_status_header(projects, column_widths)
    @output.puts ""
    @output.print "id".ljust(column_widths[0])
    @output.print "project".ljust(column_widths[1])
    @output.print "velocity".ljust(column_widths[2])
    @output.puts ""
    60.times { |num| @output.print "-" }
    @output.puts ""
  end

  def print_project_line(project, column_widths)
    @output.print project[:id].ljust(column_widths[0])
    @output.print project[:name].ljust(column_widths[1])
    @output.print project[:current_velocity].ljust(column_widths[2])
    @output.puts ""
  end

  def api_request(url)
    resource_uri = URI.parse(url)
    Net::HTTP.start(resource_uri.host, resource_uri.port) do |http|
      response = http.get(resource_uri.path, { 'X-TrackerToken' => TOKEN })
      Nokogiri::XML(response.body)
    end
  end
end