# frozen_string_literal: true

# loading gem coomponents
require "lesli_system/engines"
require "lesli_system/version"
#require "lesli_system/engine"

module LesliSystem
    class Error < StandardError; end

    def self.engine(*args, **kwargs)
        Engines.engine(*args, **kwargs)
    end

    def self.engines(**kwargs)
        Engines.engines(**kwargs)
    end
end
