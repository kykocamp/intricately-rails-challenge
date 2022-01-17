module DnsRecordService
  module Presenters
    module List
      def format(records, total)
        hostnames = {}

        dns_records = records.map do |record|
          record.hostnames.each do |hostname|
            hostname_field = hostname.hostname
            next if included.include?(hostname_field)

            hostnames[hostname_field] = { hostname: hostname_field, count: 0 } unless  hostnames.key?(hostname_field)
            hostnames[hostname_field][:count] += 1
          end

          { id: record.id, ip_address: record.ip }
        end

        { total_records: total, records: dns_records, related_hostnames: hostnames.values }
      end
    end
  end
end
