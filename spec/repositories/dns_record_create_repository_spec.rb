require 'rails_helper'

RSpec.describe DnsRecordCreateRepository do
  let(:params) do
    {
      ip: '1.1.1.1',
      hostnames_attributes: [
        { hostname: 'hostname1.org' },
        { hostname: 'hostname2.org'}
      ]
    }
  end

  describe '.create' do
    subject { described_class.create(params) }

    it 'saves one dns record and two hostnames' do
      expect { subject }.to change(DnsRecord, :count).by(1)
        .and change(Hostname, :count).by(2)
    end

    context 'when the ip sent in params already exists' do
      before { create(:dns_record, ip: '1.1.1.1') }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end