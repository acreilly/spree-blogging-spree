require 'spec_helper'

describe "InspirationEntries" do
  before(:each) do
    @inspiration_entry = create(:inspiration_entry,
      :title => "First inspiration entry",
      :body => "Body of the inspiration entry.",
      :summary => "Summary of the inspiration entry.",
      :published_at => DateTime.new(2010, 3, 11))
    @inspiration_entry.tag_list = "baz, bob"
    @inspiration_entry.category_list = "cat1"
    @inspiration_entry.save!

    @inspiration_entry2 = create(:inspiration_entry,
      :title => "Another inspiration entry",
      :body => "Another body.",
      :summary => "",
      :published_at => 1.day.ago)
    @inspiration_entry2.tag_list = "bob, ben"
    @inspiration_entry2.category_list = "cat1, cat2"
    @inspiration_entry2.save!

    @inspiration_entry3 = create(:inspiration_entry,
      :title => "Invisible inspiration entry",
      :visible => false,
      :published_at => DateTime.new(2010, 3, 11))
    @inspiration_entry3.tag_list = "baz, bob, bill"
    @inspiration_entry3.category_list = "cat3"
    @inspiration_entry3.save!
  end

  context "Categories List" do
    before do
      visit "/inspiration"
      @widget = find('.inspiration_categories_list')
    end
    it "should display the categories" do
      @widget.should have_content("cat1")
      @widget.should have_content("cat2")
    end
    it "should not display categories for inspiration entries that are not visible" do
      @widget.should_not have_content("cat3")
    end
  end

  context "Tag Cloud" do
    before do
      visit "/inspiration"
      @widget = find('.inspiration_tag_cloud')
    end
    it "should display the tags" do
      @widget.should have_content("baz")
      @widget.should have_content("bob")
      @widget.should have_content("ben")
    end
    it "should not display tags for inspiration entries that are not visible" do
      @widget.should_not have_content("bill")
    end
  end

  context "Recent Entries" do
    before do
      visit "/inspiration"
      @widget = find('.recent_inspiration_entries')
    end
    it "should display the inspiration entry titles" do
      @widget.should have_content("First inspiration entry")
      @widget.should have_content("Another inspiration entry")
    end
    it "should display the inspiration entry date" do
      @widget.should have_content("1 day ago")
    end
    it "should not display inspiration entries that are not visible" do
      @widget.should_not have_content("Invisible inspiration entry")
    end
  end

  context "News Archive" do
    before do
      visit "/inspiration"
      @widget = find('#news-archive')
    end
    it "should display the inspiration entry titles" do
      @widget.should have_content("First inspiration entry")
      @widget.should have_content("Another inspiration entry")
    end
    it "should not display inspiration entries that are not visible" do
      @widget.should_not have_content("Invisible inspiration entry")
    end
    it "should display the inspiration entry months" do
      @widget.should have_content("March")
    end
    it "should display the inspiration entry years" do
      @widget.should have_content("2010")
    end
  end


end

