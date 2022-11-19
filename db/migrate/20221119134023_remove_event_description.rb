class RemoveEventDescription < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :description
  end
end
