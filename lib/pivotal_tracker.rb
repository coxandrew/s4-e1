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

  def releases
    projects.collect do |project|
      project_releases = releases_for_project(project)
    end.flatten
  end

  def releases_with_deadlines
    releases.select { |release| release["deadline"] }
  end

  def status
    column_widths = [10, 30, 10, 8]

    print_project_status_header(projects, column_widths)
    projects.each { |project| print_project_line(project, column_widths) }
  end

  def deadlines
    sorted_releases = releases_with_deadlines.sort_by do |release|
      Date.parse(release["deadline"].to_s)
    end

    sorted_releases.each do |release|
      deadline = Date.parse(release["deadline"].to_s)
      if deadline >= Date.today
        print_deadline(release, deadline)
      end
    end
  end

  private

  def short_date(date)
    date.strftime("%Y-%m-%d")
  end

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
    65.times { |num| @output.print "-" }

    @output.puts ""
  end

  def print_project_line(project, column_widths)
    @output.print project["id"].ljust(column_widths[0])
    @output.print project["name"].ljust(column_widths[1])
    @output.print project["current_velocity"].ljust(column_widths[2])

    next_deadline = next_deadline_for_project(project)
    formatted_deadline = short_date(Date.parse(next_deadline["deadline"].to_s))
    @output.print "#{formatted_deadline}".ljust(column_widths[3])

    @output.puts ""
  end

  def print_deadline(release, deadline)
    @output.print short_date(deadline)
    @output.print "  "
    @output.print release["name"]
    @output.puts ""
  end
end
