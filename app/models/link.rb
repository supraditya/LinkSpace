class Link < ApplicationRecord
  include HTTParty

  def fetch_metadata
    response = HTTParty.get("https://jsonlink.io/api/extract?url=#{self.url}")
    if response.code == 200
      return response.parsed_response
    else
      return nil
    end
  end

  belongs_to :group
  validates :name, presence: true
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }, uniqueness: { scope: :group_id }
end
