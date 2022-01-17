module DnsRecordService
  class ParameterNotFound < StandardError; end
  class List
    include Presenters::List

    def initialize(params)
      @params = params
    end

    def execute
      raise ParameterNotFound if page.blank?

      records = query_records.limit(limit).offset(offset)
      total = query_records.count
      format(records, total)
    end

    private

    attr_reader :params

    def query_records
      @query_records ||= begin
        included_records_ids = included.empty? ?  ::DnsRecord.all.pluck(:id) : filter_included_records
        excluded_records_ids = excluded.empty? ? [] : filter_excluded_records
        records_ids = included_records_ids - excluded_records_ids
        DnsRecord.includes(:hostnames).where(id: records_ids)
      end
    end

    def filter_included_records
      ::DnsRecord
        .joins(:hostnames)
        .where('hostnames.hostname' =>  included)
        .group('id')
        .having('count(dns_records.id) = ?', included.size)
        .pluck(:id)
    end

    def filter_excluded_records
      ::DnsRecord.distinct.joins(:hostnames).where('hostnames.hostname' => excluded).pluck(:id)
    end

    def limit
      @limit ||= params[:limit] || 10
    end

    def offset
      @offset ||= (page.to_i - 1) * limit
    end

    def page
      @page ||= params[:page]
    end

    def included
      @included ||= params.include?(:included) ? params[:included].split(',') : []
    end

    def excluded
      @excluded ||= params.include?(:excluded) ? params[:excluded].split(',') : []
    end
  end
end