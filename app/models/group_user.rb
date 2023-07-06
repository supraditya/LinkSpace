class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def email
    self.user&.email
  end

  def uniqname
    self.user&.email&.split("@")&.first
  end
end
