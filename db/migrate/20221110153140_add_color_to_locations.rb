class AddColorToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :color, :string
  end
end
