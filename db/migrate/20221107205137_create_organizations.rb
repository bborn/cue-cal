class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name

      t.timestamps
    end

    create_table :organization_memberships do |t|
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
