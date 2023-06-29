class Group < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :group_users, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
