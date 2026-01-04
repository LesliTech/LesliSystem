#require "active_support/core_ext/string/inflections"
module LesliSystem
    class Engines
        ENGINES = {}
        GEMS = {}

        # engine("LesliAdmin")
        # engine("LesliAdmin", "name")
        def self.engine(engine, property=nil)

            engine = engine.to_s.camelize

            engines() if ENGINES.empty?

            # the Root engine represents the host Rails app
            engine = "Root" unless LESLI_ENGINES.include?(engine)

            # return specific property if requested
            return ENGINES[engine][property.to_sym] unless property.blank?

            # return the engine info
            return ENGINES[engine]
        end

        def self.engines
            return ENGINES unless ENGINES.empty?

            engines_and_gems(:engine, LESLI_ENGINES)

            ENGINES["Root"] = {
                :code => "root", 
                :name => "Root", 
                :path => "/",
                :version => "1.0.0",
                :summary => "",
                :description => "",
                :metadata => [],
                :build => "0000000",
                :dir => Rails.root.to_s
            }

            ENGINES
        end

        def self.gems 
            return GEMS unless GEMS.empty?
            engines_and_gems(:gem, LESLI_GEMS)
            GEMS
        end

        private

        # Lesli::System.engines()
        # Lesli::System.engines(:local => true)
        def self.engines_and_gems engine_or_gem, lesli_gems

            # due we do not know the engine mounted path we have to look up for it every
            # time we load the html view so we can use the dynamic route from the main rails app
            # we use this in the url plugin 
            lesli_gems.each do |lesli_gem|

                # skip if engine is not installed
                next unless Object.const_defined?(lesli_gem)

                # convert engine name to Ruby object
                gem_instance = "#{lesli_gem}".constantize

                gem_specification = Gem::Specification.find_by_name(lesli_gem.underscore)
                
                path = (engine_or_gem == :engine) ? gem_instance::Engine.routes.find_script_name({}) : nil

                # Define the shared data structure
                gem_data = {
                    code: lesli_gem.underscore,
                    name: lesli_gem,
                    path: path,
                    version: gem_instance::VERSION,
                    summary: gem_specification.summary,
                    description: gem_specification.description,
                    metadata: gem_specification.metadata,
                    build: gem_instance::BUILD,
                    dir: gem_specification.gem_dir
                }

                # Assign to the correct constant
                target_collection = (engine_or_gem == :engine) ? ENGINES : GEMS
                target_collection[lesli_gem] = gem_data
            end 
        end

        LESLI_GEMS = %w[
            LesliDate
            LesliView
            LesliAssets
            LesliSystem
        ]

        LESLI_ENGINES = %w[
            Lesli
            LesliBell
            LesliAdmin
            LesliBabel
            LesliAudit
            LesliMailer
            LesliShield
            LesliLetter
            LesliPapers
            LesliSupport
            LesliSecurity
            LesliCalendar
            LesliDashboard
        ]
    end
end
