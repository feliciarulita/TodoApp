require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:create_time) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2) }
    it { is_expected.to define_enum_for(:priority).with_values(high: 2, medium: 1, low: 0) }
  end

  describe "sorted" do
    let!(:first_task)  { create(:task, create_time: 2.days.ago) }
    let!(:second_task) { create(:task, create_time: Time.current) }

    it "sorts by create_time asc by default" do
      result = described_class.sorted(nil, nil)
      expect(result).to eq([ first_task, second_task ])
    end
  end

  describe "ransackable_attributes" do
    it "includes expected attributes" do
      expect(described_class.ransackable_attributes).to include("name", "status", "create_time", "end_time", "id")
    end
  end
end
