require 'spec_helper'

describe "InspirationEntries with alternative route" do
  before(:all) do
    Spree::Config['inspiration_alias'] = 'news'
    Rails.application.reload_routes!
  end
  after(:all) do
    Spree::Config['inspiration_alias'] = 'inspiration'
    Rails.application.reload_routes!
  end

  before(:each) do
    create(:inspiration_entry, title: "First inspiration entry")
    create(:inspiration_entry, title: "Another inspiration entry")
  end

  it "should display the inspiration entries under /news" do
    visit "/news"
    find('#content').should have_content("First inspiration entry")
    find('#content').should have_content("Another inspiration entry")
  end
  it "should not display the inspiration entries under /inspiration" do
    expect{ visit "/inspiration" }.to raise_error(ActionController::RoutingError)
  end
end

