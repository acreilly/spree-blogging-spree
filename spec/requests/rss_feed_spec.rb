require 'spec_helper'

describe "RSS Feed" do
  context "with a inspiration entry" do
    before(:each) do
      @inspiration_entry = create(:inspiration_entry,
        :title => "First inspiration entry",
        :body => "Body of the inspiration entry.",
        :summary => "Summary of the inspiration entry.",
        :published_at => DateTime.new(2020, 3, 11))
      @inspiration_entry.tag_list = "baz"
      @inspiration_entry.save!
    end

    it "should show the inspiration entry details" do
      visit "/inspiration/feed.rss"
      find(:xpath, "//rss/channel/item/title").text.should == "First inspiration entry"
      find(:xpath, "//rss/channel/item/content").text.should include("Body of the inspiration entry.")
      find(:xpath, "//rss/channel/item/description").text.should include("Summary of the inspiration entry.")
      find(:xpath, "//rss/channel/item/guid").text.should include("/inspiration/2020/03/11/first-inspiration-entry")
      find(:xpath, "//rss/channel/item/pubdate").text.should include("11 Mar 2020")
      find(:xpath, "//rss/channel/item/category").text.should == "baz"
    end

    it "should include links back to the orginal page in content" do
      visit "/inspiration/feed.rss"
      find(:xpath, "//rss/channel/item/content").text.should include("first appeared on")
      find(:xpath, "//rss/channel/item/description").text.should include("Read the full article")
    end

  end

  context "with multiple inspiration entries" do
    before(:each) do
      @inspiration_entry = create(:inspiration_entry,
        :title => "First inspiration entry",
        :published_at => DateTime.new(2020, 3, 11))

      @inspiration_entry2 = create(:inspiration_entry,
        :title => "Another inspiration entry",
        :published_at => DateTime.new(2020, 2, 4))

      @inspiration_entry3 = create(:inspiration_entry,
        :title => "Invisible inspiration entry",
        :visible => false,
        :published_at => DateTime.new(2020, 3, 11))
    end

    it "should include the visible inspiration entries" do
      visit "/inspiration/feed.rss"
      page.should have_content("First inspiration entry")
      page.should have_content("Another inspiration entry")
    end

    it "should not include inspiration entries that are not visible" do
      visit "/inspiration/feed.rss"
      page.should_not have_content("Invisible inspiration entry")
    end

  end

end

