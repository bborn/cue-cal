class CreateGroupMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_memberships do |t|
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end

    create_table :group_memberships do |t|
      t.references :group, null: false, foreign_key: true
      t.references :organization_membership, null: false, foreign_key: true

      t.timestamps
    end
  end
end
