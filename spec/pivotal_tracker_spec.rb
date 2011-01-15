require 'pivotal_tracker'

describe PivotalTracker do
  let(:output) { double('output').as_null_object }
  let(:pt)     { PivotalTracker.new(output) }

  it "should list all active projects" do
    output.should_receive(:print).with(/My Sample Project/)
    output.should_receive(:print).with(/Secret Project/)
    pt.status
  end

  it "should list next deadlines for each project" do
    output.should_receive(:print).with(/2011-01-20/).twice
    pt.status
  end
end