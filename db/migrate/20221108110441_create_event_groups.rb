class CreateEventGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :event_groups do |t|
      t.references :event, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
