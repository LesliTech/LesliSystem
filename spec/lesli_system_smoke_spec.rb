# frozen_string_literal: true

require "spec_helper"

RSpec.describe "LesliSystem public API" do
    it "exposes metadata for the host Rails application" do
        root = LesliSystem.engine(:root)

        expect(root).to include(
            code: "root",
            name: "Root",
            path: "/"
        )
    end

    it "discovers its own gem metadata" do
        metadata = LesliSystem.gems.fetch("LesliSystem")

        expect(metadata[:name]).to eq("LesliSystem")
        expect(metadata[:version]).to eq(LesliSystem::VERSION)
        expect(metadata[:build]).to eq(LesliSystem::BUILD)
    end

    it "builds a safe model lookup for an unavailable engine" do
        models = LesliSystem::Klass.new(engine: "UnavailableEngine").model

        expect(models.account).to be_nil
        expect(models.dashboard).to be_nil
    end
end
