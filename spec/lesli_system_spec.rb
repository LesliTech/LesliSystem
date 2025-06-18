# frozen_string_literal: true

RSpec.describe LesliSystem do
    it "has a version number" do
        expect(LesliSystem::VERSION).not_to be nil
    end

    it "has a build number" do
        expect(LesliSystem::BUILD).not_to be nil
    end
end
