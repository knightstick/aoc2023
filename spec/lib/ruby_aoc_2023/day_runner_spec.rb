# frozen_string_literal: true

RSpec.describe RubyAoc2023::DayRunner do
  describe "#run_day" do
    it "runs day 0" do
      allow(described_class).to receive(:load_input).and_return("1 0")
      p1_result, p2_result = described_class.run(day: 0)
      expect(p1_result.answer).to eq(-1)
      expect(p1_result.runtime).to be_a(Float)
      expect(p2_result.answer).to eq(-1)
      expect(p2_result.runtime).to be_a(Float)
    end
  end
end
