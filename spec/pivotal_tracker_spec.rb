require 'pivotal_tracker'

describe PivotalTracker do
  let(:output) { double('output').as_null_object }

  it "should show high-level status of active projects" do
    output.should_receive(:print).with(/My Sample Project/)
    pt = PivotalTracker.new(output)
    pt.status
  end
end