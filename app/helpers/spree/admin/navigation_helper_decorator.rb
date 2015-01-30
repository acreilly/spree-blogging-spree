Spree::Admin::NavigationHelper.class_eval do
  def link_to_inspiration_in_store(resource, options={})
    url = options[:url] || inspiration_entry_permalink(resource)
    #options[:data] = {:action => 'show'}
    link_to_with_icon('icon-view', Spree.t(:view_in_store), url, options)
  end
end
