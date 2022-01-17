module Api
  module V1
    class DnsRecordsController < ApplicationController
      # GET /dns_records
      def index
        dns_record_service = ::DnsRecordService::List.new(params)
        render json: dns_record_service.execute, status: :ok
      rescue DnsRecordService::ParameterNotFound
        head :unprocessable_entity
      end

      # POST /dns_records
      def create
        @dns_record = ::DnsRecordCreateRepository.create(dns_records_params)
        render json: { id: @dns_record.id }, status: :created
      end

      private

      def dns_records_params
        params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
      end
    end
  end
end
