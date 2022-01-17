class Hostname < ApplicationRecord
  belongs_to :dns_record

  validates :dns_record, presence: true
  validates :hostname,
            hostname: { require_fqdn: true, require_valid_tld: true },
            uniqueness: { scope: :dns_record_id },
            presence: true,
            length: { maximum: 255 }
end