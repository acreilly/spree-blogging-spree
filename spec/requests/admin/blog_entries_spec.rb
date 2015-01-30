require 'spec_helper'

describe "Inspiration Entry" do
  context "as admin user" do
    before(:each) do
      sign_in_as!(create(:admin_user))
      visit spree.admin_path

      @inspiration_entry = create(:inspiration_entry,
        :title => "First inspiration entry",
        :body => "Body of the inspiration entry.",
        :summary => "",
        :visible => true,
        :published_at => DateTime.new(2010, 3, 11))
      click_link "Inspiration"
    end

    context "index page" do
      it "should display inspiration titles" do
        page.should have_content("First inspiration entry")
      end
      it "should display inspiration published_at" do
        page.should have_content("11 Mar 2010")
      end
      it "should display inspiration visible" do
        page.should have_css('i.fa.fa-ok.green')
      end
    end

    it "should edit an existing inspiration entry" do
      within_row(1) { click_icon :edit }
      fill_in 'Title', with: 'New title'
      fill_in 'Body', with: 'New body'
      fill_in 'Tags', with: 'tag1, tag2'
      fill_in 'Categories', with: 'cat1, cat2'
      fill_in 'Summary', with: 'New summary'
      check 'Visible'
      fill_in 'Published at', with: '2013/2/1'
      fill_in 'Permalink', with: 'some-permalink-path'
      click_on 'Update'

      page.should have_content("Inspiration Entry has been successfully updated")

      page.should have_content("New body")
      page.should have_content("New summary")
      find_field('inspiration_entry_title').value.should == "New title"
      find_field('inspiration_entry_tag_list').value.should == "tag1, tag2"
      find_field('inspiration_entry_category_list').value.should == "cat1, cat2"
      find_field('inspiration_entry_published_at').value.should == "2013/02/01"
      find_field('inspiration_entry_visible').value.should == "1"
      find_field('inspiration_entry_permalink').value.should == "some-permalink-path"
    end

    it "should add a featured image to a inspiration entry" do
      file_path = Rails.root + "../../spec/support/image.png"

      within_row(1) { click_icon :edit }
      attach_file('inspiration_entry_inspiration_entry_image_attributes_attachment', file_path)
      click_button "Update"
      page.should have_content("successfully updated")
      page.should have_content("image.png")

      fill_in 'inspiration_entry_inspiration_entry_image_attributes_alt', :with => "image alt text"
      click_button "Update"
      page.should have_content("successfully updated")
      find_field('Alternative Text').value.should == "image alt text"
      page.should have_content("image.png")
    end

  end
end