require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:notes) }
  it { is_expected.to have_many(:user_roles) }
  it { is_expected.to have_many(:tasks) }
  it { is_expected.to have_many(:reports) }
end
