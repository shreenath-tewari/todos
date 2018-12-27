class Todo < ApplicationRecord
  # establish relationships
  has_many :items, dependent: :destroy

  # validation rules
  validates_presence_of :title
  validates_presence_of :created_by
end
