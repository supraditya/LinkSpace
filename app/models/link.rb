class Link < ApplicationRecord
  include HTTParty

  belongs_to :group
  validates :name, presence: true
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }, uniqueness: { scope: :group_id }
end
