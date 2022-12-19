class AddFinalUrlToUrls < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :final_url, :string, null: false
  end
end
