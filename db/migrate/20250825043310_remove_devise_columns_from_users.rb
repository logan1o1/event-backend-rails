class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:users, :encrypted_password)
      remove_column :users, :encrypted_password
    end
    
    if column_exists?(:users, :reset_password_token)
      remove_column :users, :reset_password_token
    end
    
    if column_exists?(:users, :reset_password_sent_at)
      remove_column :users, :reset_password_sent_at
    end
    
    if column_exists?(:users, :remember_created_at)
      remove_column :users, :remember_created_at
    end
    
    if column_exists?(:users, :jti)
      remove_column :users, :jti
    end
  end
end
