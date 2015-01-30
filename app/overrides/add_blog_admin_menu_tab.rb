Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "inspiration_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:inspiration_entries, :label => 'Inspiration', :url => spree.admin_inspiration_entries_path, :icon => 'file') if can? :manage, Spree::InspirationEntry %>",
                     :disabled => false)
