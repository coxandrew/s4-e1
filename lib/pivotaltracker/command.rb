module PivotalTracker
  class OptionParser::InvalidCommand < Exception; end

  class Command
    def self.status
      account = Account.new
      printer = Printer.new(STDOUT)
      printer.print_status(account.projects)
    end

    def self.deadlines
      account = Account.new
      printer = Printer.new(STDOUT)
      printer.print_deadlines(account.upcoming_deadlines)
    end

    def self.method_missing(sym, *args, &block)
      raise OptionParser::InvalidCommand
    end
  end
end