require 'rails_helper'

RSpec.describe User, type: :model do
  # check db relationships
  it { should have_many(:todos) }

  # check validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
