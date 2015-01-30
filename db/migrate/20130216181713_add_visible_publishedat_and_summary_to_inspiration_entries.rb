class AddVisiblePublishedatAndSummaryToInspirationEntries < ActiveRecord::Migration
  def change
    add_column :spree_inspiration_entries, :visible, :boolean, :default => false
    add_column :spree_inspiration_entries, :published_at, :datetime
    add_column :spree_inspiration_entries, :summary, :text
  end
end
