class Url < ApplicationRecord
  attr_accessor :short_url
  after_initialize :set_initial_hits
  validates :original_url, format: { with: /\A\s*#{URI::regexp}\s*\z/, message: 'must be a valid URL' }
  validates :original_url, :hits, presence: true

  def set_initial_hits
    # this sets hits to zero but only if they are currently nil
    self.hits ||= 0
  end

  def hit
    self.hits = self.hits + 1
  end
end

