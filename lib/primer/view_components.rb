# frozen_string_literal: true

require "primer/view_components/version"
require "primer/view_components/engine"

module Primer
  # :nodoc
  module ViewComponents
    DEFAULT_STATUSES_PATH = File.expand_path("static")
    DEFAULT_STATUS_FILE_NAME = "statuses.json"

    # generate_statuses returns a hash mapping component name to
    # the component's status
    def self.generate_statuses
      statuses = {}
      components = Primer::Component.descendants

      components.each do |component|
        statuses[component.to_s] = component.status.to_s
      end

      statuses
    end

    # dump_statuses generates the status hash and then serializes
    # it as json at the given path
    def self.dump_statuses(path: DEFAULT_STATUSES_PATH)
      require "json"

      statuses = generate_statuses

      File.open(File.join(path, DEFAULT_STATUS_FILE_NAME), "w") do |f|
        f.write(statuses.to_json)
        f.write($INPUT_RECORD_SEPARATOR)
      end
    end

    # read_statuses returns a JSON string matching the output of
    # generate_statuses
    def self.read_statuses(path: DEFAULT_STATUSES_PATH)
      File.read(File.join(path, DEFAULT_STATUS_FILE_NAME))
    end
  end
end
