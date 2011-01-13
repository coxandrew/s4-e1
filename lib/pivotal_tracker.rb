require 'nokogiri'
require 'net/http'
require 'uri'

class PivotalTracker
  API_BASE_URI = "http://www.pivotaltracker.com/services/v3/"
  TOKEN        = '6f23b318f92337792996c9d4e1fb6ed7'
  PROJECT_ID   = '198977'

  def initialize(output)
    @output = output
  end

  def status
    response = api_request("#{API_BASE_URI}projects/#{PROJECT_ID}")

    projects = []
    response.xpath('project').each do |project|
      projects << {
        :name             => project.xpath('name').text,
        :iteration_length => project.xpath('iteration_length').text
      }
    end

    @output.puts "#{projects}"
  end

  private

  def api_request(url)
    resource_uri = URI.parse(url)
    Net::HTTP.start(resource_uri.host, resource_uri.port) do |http|
      response = http.get(resource_uri.path, { 'X-TrackerToken' => TOKEN })
      Nokogiri::XML(response.body)
    end
  end
end