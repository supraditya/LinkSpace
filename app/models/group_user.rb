class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def email
    User.find(self.user_id).email
  end

  def uniqname
    User.find(self.user_id).email.split("@")[0]
  end
end
