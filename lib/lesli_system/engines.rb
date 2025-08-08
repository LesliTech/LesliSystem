#require "active_support/core_ext/string/inflections"
module LesliSystem
    class Engines
        ENGINES = {}

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

        # Lesli::System.engines()
        # Lesli::System.engines(:local => true)
        def self.engines local: false

            return ENGINES unless ENGINES.empty?

            # due we do not know the engine mounted path we have to look up for it every
            # time we load the html view so we can use the dynamic route from the main rails app
            # we use this in the url plugin 
            LESLI_ENGINES.each do |engine|

                # skip if engine is not installed
                next unless Object.const_defined?(engine)

                # convert engine name to Ruby object
                engine_instance = "#{engine}".constantize

                # check if engines installed locally are required
                if local 

                    # build the path were engines should be installed
                    engine_local_path = Rails.root.join("engines", engine)

                    # do not include engines if not is locally installed
                    next unless File.exist?(engine_local_path)
                end

                gem_specification = Gem::Specification.find_by_name(engine.underscore)
                
                # engine completelly information
                ENGINES[engine] = {
                    :code => engine.underscore, 
                    :name => engine, 
                    :path => engine_instance::Engine.routes.find_script_name({}),
                    :version => engine_instance::VERSION,
                    :summary => gem_specification.summary,
                    :description => gem_specification.description,
                    :metadata => gem_specification.metadata,
                    :build => engine_instance::BUILD,
                    :dir => gem_specification.gem_dir
                }
            end 

            # also include the rails main_app
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

        private

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
