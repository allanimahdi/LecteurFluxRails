class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.datetime :pulished, :default => DateTime.now
      t.text :content
      t.string :url
      t.integer :feed_id
      t.boolean :lu, :default => false
      t.timestamps
    end
  end
end
