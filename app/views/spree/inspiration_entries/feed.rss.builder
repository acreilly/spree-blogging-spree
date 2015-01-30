xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{Spree::Config[:site_name]} Inspiration"
    xml.description ""
    xml.link inspiration_url

    @inspiration_entries.each do |inspiration_entry|
      xml.item do
        xml.title inspiration_entry.title
        xml.description inspiration_entry.entry_summary + inspiration_full_article_html(inspiration_entry)
        xml.content inspiration_entry.body + inspiration_first_appeared_html(inspiration_entry), :type => :html
        xml.pubDate inspiration_entry.published_at.to_s(:rfc822)
        xml.link inspiration_entry_url_permalink(inspiration_entry)
        xml.guid inspiration_entry_url_permalink(inspiration_entry)
        inspiration_entry.tag_list.each do |tag|
          xml.category tag
        end
      end
    end
  end
end



