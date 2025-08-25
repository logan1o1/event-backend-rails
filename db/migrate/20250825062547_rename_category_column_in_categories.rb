class RenameCategoryColumnInCategories < ActiveRecord::Migration[8.0]
  def change
    rename_column :categories, :category, :name
  end
end
