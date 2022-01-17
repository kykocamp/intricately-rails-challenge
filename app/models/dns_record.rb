class DnsRecord < ApplicationRecord
  has_many :hostnames
  accepts_nested_attributes_for :hostnames

  validates :ip, uniqueness: true, presence: true, length: { maximum: 15 }
  validate :valid_ip?

  private

  def valid_ip?
    return true if !!(ip =~ Resolv::IPv4::Regex)

    errors.add(:ip, :invalid_ip)
  end
end