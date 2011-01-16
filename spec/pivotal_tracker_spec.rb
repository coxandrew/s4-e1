require 'pivotal_tracker'

describe PivotalTracker do
  context "status" do
    let(:output) { double('output').as_null_object }
    let(:pt)     { PivotalTracker.new(output) }

    it "should list all active projects" do
      output.should_receive(:print).with(/My Sample Project/)
      output.should_receive(:print).with(/Secret Project/)
      pt.status
    end

    it "should list next deadlines for each project" do
      output.should_receive(:print).with(/2011-01-30/)
      output.should_receive(:print).with(/2011-02-05/)
      pt.status
    end
  end
end