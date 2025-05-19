class AddLocationToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :location, :string
  end
end
