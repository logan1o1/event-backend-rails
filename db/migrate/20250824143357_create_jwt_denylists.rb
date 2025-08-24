class CreateJwtDenylists < ActiveRecord::Migration[8.0]
  def change
    create_table :jwt_denylists do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :jwt_denylists, :jti
    add_index :jwt_denylists, :exp
  end
end
