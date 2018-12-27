require 'rails_helper'

RSpec.describe Item, type: :model do
  # check model relationships
  it { should belong_to(:todo) }

  # check validations
  it { should validate_presence_of(:name) }
end
