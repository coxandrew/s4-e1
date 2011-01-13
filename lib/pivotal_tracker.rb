require 'hpricot'
require 'net/http'
require 'uri'

TOKEN = '6f23b318f92337792996c9d4e1fb6ed7'
PROJECT_ID = '198977'

class PivotalTracker
  def initialize(output)
    @output = output
  end

  def status
    resource_uri = URI.parse("http://www.pivotaltracker.com/services/v3/projects/#{PROJECT_ID}")
    response = Net::HTTP.start(resource_uri.host, resource_uri.port) do |http|
      http.get(resource_uri.path, {'X-TrackerToken' => TOKEN})
    end

    doc = Hpricot(response.body).at('project')

    @project = {
      :name             => doc.at('name').innerHTML,
      :iteration_length => doc.at('iteration_length').innerHTML,
      :week_start_day   => doc.at('week_start_day').innerHTML,
      :point_scale      => doc.at('point_scale').innerHTML
    }

    @output.puts "#{@project}"
  end
end