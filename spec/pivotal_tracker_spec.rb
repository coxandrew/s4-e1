require 'pivotal_tracker'

describe PivotalTracker do
  context "status" do
    let(:output) { double('output').as_null_object }
    let(:pt)     { PivotalTracker.new(output) }

    it "lists all active projects" do
      output.should_receive(:print).with(/My Sample Project/)
      output.should_receive(:print).with(/Secret Project/)
      pt.status
    end

    it "lists next deadlines for each project" do
      output.should_receive(:print).with(/2011-01-30/)
      output.should_receive(:print).with(/2011-02-05/)
      pt.status
    end
  end

  context "deadlines" do
    let(:output) { double('output').as_null_object }
    let(:pt)     { PivotalTracker.new(output) }

    it "lists all upcoming deadlines" do
      output.should_receive(:print).with(/2011-01-30/)
      output.should_receive(:print).with(/2011-02-05/)
      output.should_receive(:print).with(/2011-02-28/)
      pt.deadlines
    end
  end
end