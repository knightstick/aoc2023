# frozen_string_literal: true

RSpec.describe RubyAoc2023 do
  it "has a version number" do
    expect(RubyAoc2023::VERSION).not_to be nil
  end

  describe "greeting" do
    it "greets the world" do
      expect(described_class.greeting).to eq("Hello, World!")
    end

    it "greets someone else" do
      expect(described_class.greeting("Chris")).to eq("Hello, Chris!")
    end
  end

  describe "run_day" do
    it "runs day 0" do
      allow(described_class::DayRunner).to receive(:load_input).and_return("1 0")
      part1, part2 = described_class.run_day(day: 0)
      expect(part1.answer).to eq(-1)
      expect(part1.runtime).to be_a(Float)
      expect(part2.answer).to eq(-1)
      expect(part2.runtime).to be_a(Float)
    end
  end
end
