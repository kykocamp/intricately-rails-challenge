class CreateHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :hostnames do |t|
      t.belongs_to :dns_record, null: false, foreign_key: { on_delete: :cascade }
      t.string :hostname, null: false, limit: 255

      t.timestamps
    end

    add_index :hostnames, %i[dns_record_id hostname], unique: true
    add_index :hostnames, :hostname
  end
end
