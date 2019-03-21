class Url < ApplicationRecord
  validates :original_url,
    format: { with: /\A\s*#{URI::regexp}\s*\z/, message: 'must be a valid URL' },
    presence: true
  validates :hits, presence: true

  def find_by_hash(hash)
    decoded_id = self.decode(hash)
    find(decoded_id)
  end

  def hit
    increment!(:hits)
  end

  def encode(id)
    encoded_id = Base62.encode(id)
    # @url.short_url = ENV['APP_DOMAIN'] + id_hash
    encoded_id
  end

  def decode(encoded_id)
    id = Base62.decode(encoded_id.to_s)

    if id.nil?
      Rails.logger.info 'id is null'
    else
      Rails.logger.info "id is #{id}"
      id
    end
  end

  def generate_short_url(id)
    encoded_id = encode(id)
    short_url = 'https://hashfier.herokuapp.com/' + encoded_id
    short_url
  end
  
end

