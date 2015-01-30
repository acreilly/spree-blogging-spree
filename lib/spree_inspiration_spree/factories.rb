FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_inspiration_spree/factories'

  factory :inspiration_entry, :class => Spree::InspirationEntry do
    title 'A Inspiration Entry Title'
    body 'A Inspiration Entry Body'
    permalink {|entry| entry.title.to_url }
    published_at DateTime.new(2010)
    visible true
    summary 'A Inspiration Entry Summary'
  end
end
