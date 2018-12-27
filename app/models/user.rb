class User < ApplicationRecord
  # password setup
  has_secure_password

  # establish relationships
  has_many :todos, foreign_key: :created_by

  # validation rules
  validates_presence_of :name, :email, :password_digest
end
