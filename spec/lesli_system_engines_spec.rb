require "rails"
require "spec_helper"

RSpec.describe LesliSystem::Engines, type: :model do
    context "when working with engines" do
        it "has Root metadata" do
            engines = LesliSystem::Engines.engines

            expect(engines).to have_key("Root")
            expect(engines["Root"][:code]).to eq("root")
            expect(engines["Root"][:name]).to eq("Root")
            expect(engines["Root"][:path]).to eq("/")
            expect(engines["Root"][:version]).to eq("1.0.0")
            expect(engines["Root"][:build]).to eq("0000000")
            expect(engines["Root"][:dir]).to eq("")
        end
    end

    context "when working with engine" do
        it "has Root metadata" do
            engine = LesliSystem::Engines.engine("Root")

            expect(engine[:code]).to eq("root")
            expect(engine[:name]).to eq("Root")
            expect(engine[:path]).to eq("/")
            expect(engine[:version]).to eq("1.0.0")
            expect(engine[:build]).to eq("0000000")
            expect(engine[:dir]).to eq("")
        end
    end
end
