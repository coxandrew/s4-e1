require 'pivotal_tracker'

describe PivotalTracker do
  context "#print_status" do
    let(:output) { double('output').as_null_object }
    let(:pt)     { PivotalTracker.new(output) }

    it "lists all active projects" do
      output.should_receive(:print).with(/My Sample Project/)
      output.should_receive(:print).with(/Secret Project/)
      pt.print_status
    end

    it "lists next deadlines for each project" do
      output.should_receive(:print).with(/2011-01-30/)
      output.should_receive(:print).with(/2011-02-05/)
      pt.print_status
    end
  end

  context "#print_deadlines" do
    let(:output) { double('output').as_null_object }
    let(:pt)     { PivotalTracker.new(output) }

    it "lists all upcoming deadlines" do
      output.should_receive(:print).with(/2011-01-30/)
      output.should_receive(:print).with(/2011-02-05/)
      output.should_receive(:print).with(/2011-02-28/)
      pt.print_deadlines
    end
  end
end