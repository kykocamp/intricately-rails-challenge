require 'rails_helper'

RSpec.describe Hostname, type: :model do
  describe 'columns validations' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:dns_record_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:hostname).of_type(:string).with_options(null: false, limit: 255) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'relationships validations' do
    it { is_expected.to belong_to(:dns_record) }
  end

  describe 'index validations' do
    it { is_expected.to have_db_index(%i[dns_record_id hostname]).unique(true) }
    it { is_expected.to have_db_index(:hostname) }
  end

  describe 'fields validations' do
    it { is_expected.to validate_presence_of(:dns_record) }
    it { is_expected.to validate_presence_of(:hostname) }
    it { is_expected.to validate_length_of(:hostname).is_at_most(255) }
  end

  describe 'validate if hostname is valid' do
    subject { hostname.valid? }

    let(:hostname) { build(:hostname, hostname: value) }

    context 'when hostname is an invalid hostname' do
      let(:value) { 'a' }

      it { is_expected.to be_falsey }
    end

    context 'when hostname is a valid hostname' do
      let(:value) { 'test.info' }

      it { is_expected.to be_truthy }
    end
  end
end