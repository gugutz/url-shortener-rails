class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_url, null: false
      t.integer :hits, null: false, default: 0

      t.timestamps
    end
  end
end
