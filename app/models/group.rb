class Group < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :group_users, dependent: :destroy
end
