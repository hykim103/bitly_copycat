class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :destination, null: false
      t.string :title
      t.string :short_link

      t.timestamps
    end
  end
end
