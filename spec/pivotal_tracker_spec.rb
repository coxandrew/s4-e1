require 'pivotal_tracker'

describe PivotalTracker do
  let(:output) { double('output').as_null_object }

  it "should list all active projects" do
    output.should_receive(:print).with(/My Sample Project/)
    output.should_receive(:print).with(/Secret Project/)

    pt = PivotalTracker.new(output)
    pt.status
  end

  it "should list next deadlines for each project" do
    next_sample_project_deadline = /2011-01-20/
    output.should_receive(:print).with(next_sample_project_deadline)
  end
end