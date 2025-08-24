class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
