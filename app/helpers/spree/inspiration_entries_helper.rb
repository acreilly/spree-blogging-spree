module Spree
  module InspirationEntriesHelper
    def post_link_list
     link = Struct.new(:name,:url)
     InspirationEntry.recent.collect { |post| link.new( post.title, inspiration_entry_permalink(post)) }
    end

    def inspiration_entry_permalink(e)
      unless e.published_at.nil?
        inspiration_entry_permalink_path :year => e.published_at.strftime("%Y"), :month => e.published_at.strftime("%m"), :day => e.published_at.strftime("%d"), :slug => e.permalink
      else
        inspiration_entry_permalink_path :year => "na", :month => "na", :day => "na", :slug => e.permalink
      end
    end

    def inspiration_entry_url_permalink(e)
      unless e.published_at.nil?
         inspiration_entry_permalink_url :year => e.published_at.strftime("%Y"), :month => e.published_at.strftime("%m"), :day => e.published_at.strftime("%d"), :slug => e.permalink
       else
        inspiration_entry_permalink_url :year => "na", :month => "na", :day => "na", :slug => e.permalink
      end
    end

    def inspiration_full_article_html(inspiration_entry)
      "<br><br>Read the full article #{link_to inspiration_entry.title, inspiration_entry_url_permalink(inspiration_entry)} at #{link_to "#{Spree::Config[:site_name]} Inspiration", inspiration_url}."
    end

    def inspiration_first_appeared_html(inspiration_entry)
      "<br><br>The article #{link_to inspiration_entry.title, inspiration_entry_url_permalink(inspiration_entry)} first appeared on #{link_to "#{Spree::Config[:site_name]} Inspiration", inspiration_url}."
    end

    def inspiration_entry_tag_list_html inspiration_entry
      inspiration_entry.tag_list.map {|tag| link_to tag, inspiration_tag_path(tag) }.join(", ").html_safe
    end

    def inspiration_entry_category_list_html inspiration_entry
      inspiration_entry.category_list.map {|category| link_to category, inspiration_category_path(category) }.join(", ").html_safe
    end

    def tag_cloud(tags, classes)
      return [] if tags.blank?
      max_count = tags.sort_by(&:count).last.count.to_f
      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1))
        yield tag, classes[index.nan? ? 0 : index.round]
      end
    end
  end
end
