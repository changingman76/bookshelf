class AddBorrowedToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :borrowed, :boolean, default: false
  end
end
