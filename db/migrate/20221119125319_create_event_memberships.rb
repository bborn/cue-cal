class CreateEventMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :event_memberships do |t|
      t.references :organization_membership, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
