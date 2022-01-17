class DnsRecordCreateRepository
  def self.create(params)
    new(params).create
  end

  def initialize(params)
    @params = params
  end

  def create
    ::DnsRecord.create!(params)
  end

  private

  attr_reader :params
end