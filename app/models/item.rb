class Item < ApplicationRecord
  # establish relationships
  belongs_to :todo

  # validation rules
  validates_presence_of :name
end
