class AddUrlAndCatagoryToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :poster_url, :string
    add_reference :events, :category, null: false, foreign_key: true
  end
end
