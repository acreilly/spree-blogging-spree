require 'spec_helper'

describe "InspirationEntries" do
  before(:each) do

    @inspiration_entry = create(:inspiration_entry,
      :title => "First inspiration entry",
      :body => "Body of the inspiration entry.",
      :summary => "Summary of the inspiration entry.",
      :published_at => DateTime.new(2020, 3, 11))
    @inspiration_entry.tag_list = "baz, bob"
    @inspiration_entry.category_list = "cat1"
    @inspiration_entry.save!

    @inspiration_entry2 = create(:inspiration_entry,
      :title => "Another inspiration entry",
      :body => "Another body.",
      :summary => "",
      :published_at => DateTime.new(2020, 2, 4))
    @inspiration_entry2.tag_list = "bob, ben"
    @inspiration_entry2.category_list = "cat1, cat2"
    @inspiration_entry2.save!

    @inspiration_entry3 = create(:inspiration_entry,
      :title => "Invisible inspiration entry",
      :visible => false,
      :published_at => DateTime.new(2020, 3, 11))
    @inspiration_entry3.tag_list = "baz, bob"
    @inspiration_entry3.category_list = "cat3"
    @inspiration_entry3.save!
  end

  context "index page" do
    it "should display the inspiration entry titles" do
      visit "/inspiration"
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Another inspiration entry")
    end
    it "should not display invisible inspiration entries" do
      visit "/inspiration"
      find('#content').should_not have_content("Invisible inspiration entry")
    end
    it "should display the inspiration entry body summary" do
      visit "/inspiration"
      find('#content').should have_content("Summary of the inspiration entry.")
      find('#content').should have_content("Another body.")
    end
    it "should display the inspiration entry tags" do
      visit "/inspiration"
      find('#content').should have_content("baz")
      find('#content').should have_content("bob")
      find('#content').should have_content("ben")
      find('#content').should have_content("cat1")
      find('#content').should have_content("cat2")
    end
    it "should display the inspiration entry published dates" do
      visit "/inspiration"
      find('#content').should have_content("11 Mar 2020")
      find('#content').should have_content("4 Feb 2020")
    end
  end

  context "inspiration entry page" do
    it "should display the inspiration entry details" do
      visit "/inspiration/2020/03/11/first-inspiration-entry"
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Body of the inspiration entry.")
      find('#content').should have_content("Torony Polser")
    end
    it "should not display a different inspiration entry" do
      visit "/inspiration/2020/03/11/first-inspiration-entry"
      find('#content').should_not have_content("Another inspiration entry")
      find('#content').should_not have_content("Another body")
    end
    it "should display the inspiration entry tags" do
      visit "/inspiration/2020/03/11/first-inspiration-entry"
      find('#content').should have_content("baz")
      find('#content').should have_content("bob")
      find('#content').should_not have_content("ben")
    end
    it "should display the inspiration entry categories" do
      visit "/inspiration/2020/03/11/first-inspiration-entry"
      find('#content').should have_content("cat1")
      find('#content').should_not have_content("cat2")
    end
    it "should display the published_at date" do
      visit "/inspiration/2020/03/11/first-inspiration-entry"
      find('#content').should have_content("11 Mar 2020")
    end
  end

  context "tag page" do
    it "should display the inspiration entries" do
      visit "/inspiration/tag/bob"
      find('#content').should have_content("Tag: bob")
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Summary of the inspiration entry.")
      find('#content').should have_content("Another inspiration entry")
      find('#content').should have_content("Another body")
    end
    it "should only diplay the tagged inspiration entries" do
      visit "/inspiration/tag/baz"
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Summary of the inspiration entry.")
      find('#content').should_not have_content("Another inspiration entry")
      find('#content').should_not have_content("Another body")
    end
    it "should display the tag title" do
      visit "/inspiration/tag/bob"
      find('#content').should have_content("Tag: bob")
    end
    it "should not display invisible inspiration entries" do
      visit "/inspiration/tag/bob"
      find('#content').should_not have_content("Invisible inspiration entry")
    end
  end

  context "archive page" do
    it "should display the inspiration entries" do
      visit "/inspiration/2020"
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Summary of the inspiration entry.")
      find('#content').should have_content("Another inspiration entry")
      find('#content').should have_content("Another body")
    end
    it "should not diplay inspiration entries for the wrong period" do
      visit "/inspiration/2020/02"
      find('#content').should_not have_content("First inspiration entry")
      find('#content').should_not have_content("Summary of the inspiration entry.")
      find('#content').should have_content("Another inspiration entry")
      find('#content').should have_content("Another body")
    end
    it "should display the archive year" do
      visit "/inspiration/2020"
      find('#content').should have_content("Archive: 2020")
    end
    it "should display the archive month and year" do
      visit "/inspiration/2020/02"
      find('#content').should have_content("Archive: February 2020")
    end
    it "should not display invisible inspiration entries" do
      visit "/inspiration/2020"
      find('#content').should_not have_content("Invisible inspiration entry")
    end
  end


  context "category page" do
    it "should display the inspiration entries" do
      visit "/inspiration/category/cat1"
      find('#content').should have_content("First inspiration entry")
      find('#content').should have_content("Summary of the inspiration entry.")
      find('#content').should have_content("Another inspiration entry")
      find('#content').should have_content("Another body.")
    end
    it "should only diplay the inspiration entries in the category" do
      visit "/inspiration/category/cat2"
      find('#content').should_not have_content("First inspiration entry")
      find('#content').should have_content("Another inspiration entry")
    end
    it "should display the category title" do
      visit "/inspiration/category/cat1"
      find('#content').should have_content("Category: cat1")
    end
    it "should not display invisible inspiration entries" do
      visit "/inspiration/category/cat3"
      find('#content').should_not have_content("Invisible inspiration entry")
    end
  end
end

