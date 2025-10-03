RSpec.describe Task, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:create_time) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2) }
    it { is_expected.to define_enum_for(:priority).with_values(high: 0, medium: 1, low: 2) }
  end
end
