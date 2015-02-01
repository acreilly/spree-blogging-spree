class CreateInspirationEntries < ActiveRecord::Migration
  def self.up
    create_table :spree_inspiration_entries do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :permalink, :string
      t.column :pinterest_url, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_inspiration_entries
  end
end
