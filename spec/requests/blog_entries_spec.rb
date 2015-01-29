require 'spec_helper'

describe "BlogEntries" do
  before(:each) do

    @blog_entry = create(:blog_entry,
      :title => "First blog entry",
      :body => "Body of the blog entry.",
      :summary => "Summary of the blog entry.",
      :published_at => DateTime.new(2020, 3, 11))
    @blog_entry.tag_list = "baz, bob"
    @blog_entry.category_list = "cat1"
    @blog_entry.save!

    @blog_entry2 = create(:blog_entry,
      :title => "Another blog entry",
      :body => "Another body.",
      :summary => "",
      :published_at => DateTime.new(2020, 2, 4))
    @blog_entry2.tag_list = "bob, ben"
    @blog_entry2.category_list = "cat1, cat2"
    @blog_entry2.save!

    @blog_entry3 = create(:blog_entry,
      :title => "Invisible blog entry",
      :visible => false,
      :published_at => DateTime.new(2020, 3, 11))
    @blog_entry3.tag_list = "baz, bob"
    @blog_entry3.category_list = "cat3"
    @blog_entry3.save!
  end

  context "index page" do
    it "should display the blog entry titles" do
      visit "/blog"
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Another blog entry")
    end
    it "should not display invisible blog entries" do
      visit "/blog"
      find('#content').should_not have_content("Invisible blog entry")
    end
    it "should display the blog entry body summary" do
      visit "/blog"
      find('#content').should have_content("Summary of the blog entry.")
      find('#content').should have_content("Another body.")
    end
    it "should display the blog entry tags" do
      visit "/blog"
      find('#content').should have_content("baz")
      find('#content').should have_content("bob")
      find('#content').should have_content("ben")
      find('#content').should have_content("cat1")
      find('#content').should have_content("cat2")
    end
    it "should display the blog entry published dates" do
      visit "/blog"
      find('#content').should have_content("11 Mar 2020")
      find('#content').should have_content("4 Feb 2020")
    end
  end

  context "blog entry page" do
    it "should display the blog entry details" do
      visit "/blog/2020/03/11/first-blog-entry"
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Body of the blog entry.")
      find('#content').should have_content("Torony Polser")
    end
    it "should not display a different blog entry" do
      visit "/blog/2020/03/11/first-blog-entry"
      find('#content').should_not have_content("Another blog entry")
      find('#content').should_not have_content("Another body")
    end
    it "should display the blog entry tags" do
      visit "/blog/2020/03/11/first-blog-entry"
      find('#content').should have_content("baz")
      find('#content').should have_content("bob")
      find('#content').should_not have_content("ben")
    end
    it "should display the blog entry categories" do
      visit "/blog/2020/03/11/first-blog-entry"
      find('#content').should have_content("cat1")
      find('#content').should_not have_content("cat2")
    end
    it "should display the published_at date" do
      visit "/blog/2020/03/11/first-blog-entry"
      find('#content').should have_content("11 Mar 2020")
    end
  end

  context "tag page" do
    it "should display the blog entries" do
      visit "/blog/tag/bob"
      find('#content').should have_content("Tag: bob")
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Summary of the blog entry.")
      find('#content').should have_content("Another blog entry")
      find('#content').should have_content("Another body")
    end
    it "should only diplay the tagged blog entries" do
      visit "/blog/tag/baz"
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Summary of the blog entry.")
      find('#content').should_not have_content("Another blog entry")
      find('#content').should_not have_content("Another body")
    end
    it "should display the tag title" do
      visit "/blog/tag/bob"
      find('#content').should have_content("Tag: bob")
    end
    it "should not display invisible blog entries" do
      visit "/blog/tag/bob"
      find('#content').should_not have_content("Invisible blog entry")
    end
  end

  context "archive page" do
    it "should display the blog entries" do
      visit "/blog/2020"
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Summary of the blog entry.")
      find('#content').should have_content("Another blog entry")
      find('#content').should have_content("Another body")
    end
    it "should not diplay blog entries for the wrong period" do
      visit "/blog/2020/02"
      find('#content').should_not have_content("First blog entry")
      find('#content').should_not have_content("Summary of the blog entry.")
      find('#content').should have_content("Another blog entry")
      find('#content').should have_content("Another body")
    end
    it "should display the archive year" do
      visit "/blog/2020"
      find('#content').should have_content("Archive: 2020")
    end
    it "should display the archive month and year" do
      visit "/blog/2020/02"
      find('#content').should have_content("Archive: February 2020")
    end
    it "should not display invisible blog entries" do
      visit "/blog/2020"
      find('#content').should_not have_content("Invisible blog entry")
    end
  end


  context "category page" do
    it "should display the blog entries" do
      visit "/blog/category/cat1"
      find('#content').should have_content("First blog entry")
      find('#content').should have_content("Summary of the blog entry.")
      find('#content').should have_content("Another blog entry")
      find('#content').should have_content("Another body.")
    end
    it "should only diplay the blog entries in the category" do
      visit "/blog/category/cat2"
      find('#content').should_not have_content("First blog entry")
      find('#content').should have_content("Another blog entry")
    end
    it "should display the category title" do
      visit "/blog/category/cat1"
      find('#content').should have_content("Category: cat1")
    end
    it "should not display invisible blog entries" do
      visit "/blog/category/cat3"
      find('#content').should_not have_content("Invisible blog entry")
    end
  end
end

