class CreateDnsRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :dns_records do |t|
      t.string :ip, null: false, limit: 15

      t.timestamps
    end

    add_index :dns_records, :ip, unique: true
  end
end
