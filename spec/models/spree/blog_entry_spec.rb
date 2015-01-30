require 'spec_helper'

describe Spree::InspirationEntry do

  context "with a date and a inspiration_entry" do
    before do
      @date = DateTime.new(2009, 3, 11)
      @inspiration_entry = create(:inspiration_entry, :published_at => @date)
    end

    context "and potentially incomplete date information" do
      before do
        @year = {:year => 2009}
        @year_month = {:year => 2009, :month => 3}
        @year_month_day = {:year => 2009, :month => 3, :day => 11}
        @missing_year = {:year => 1999}
        @missing_year_month = {:year => 1999, :month => 6}
        @missing_year_month_day = {:year => 1999, :month => 6, :day => 6}
      end

      it "should be able to find matching entries" do
        Spree::InspirationEntry.by_date(@year).should include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@year_month).should include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@year_month_day).should include(@inspiration_entry)

        Spree::InspirationEntry.by_date(@missing_year).should_not include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@missing_year_month).should_not include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@missing_year_month_day).should_not include(@inspiration_entry)
      end
    end

    context "and a type of time period" do
      it "should be able to find matching entries" do
        Spree::InspirationEntry.by_date(@date, :year).should include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@date, :month).should include(@inspiration_entry)
        Spree::InspirationEntry.by_date(@date, :day).should include(@inspiration_entry)
      end
    end
  end

  context "entry_summary" do
    before do
      @inspiration_entry = create(:inspiration_entry, :body => "A body for the inspiration post.", :summary => "")
    end
    it "should return the body if the summary is blank" do
      @inspiration_entry.entry_summary.should == "A body for the inspiration post...."
    end
    it "should return summary if when it is present" do
      @inspiration_entry.update_attribute(:summary, "This is my summary.")
      @inspiration_entry.entry_summary.should == "This is my summary."
    end
  end


  context "with a few inspiration_entries" do
    before do
      @first_entry = create(:inspiration_entry, :published_at => DateTime.new(2010, 1))
      @second_entry = create(:inspiration_entry, :published_at => DateTime.new(2011, 2))
      @third_entry = create(:inspiration_entry, :published_at => DateTime.new(2012, 3))
    end

    it "should recent should return the recent ordered inspiration entries" do
      inspiration_entries = Spree::InspirationEntry.recent(2)
      inspiration_entries.count.should == 2
      inspiration_entries.first.should == @third_entry
      inspiration_entries.last.should == @second_entry
    end

    it "should recent should return the recent ordered inspiration entries" do
      @second_entry.update_attribute(:visible, false)
      inspiration_entries = Spree::InspirationEntry.visible
      inspiration_entries.should include(@first_entry)
      inspiration_entries.should include(@third_entry)
      inspiration_entries.should_not include(@second_entry)
    end

    it "should generate data for news archive widget" do
      @invisible_entry = create(:inspiration_entry, :published_at => DateTime.new(2012, 3), :visible => false)
      organized_entries = Spree::InspirationEntry.organize_inspiration_entries

      organized_entries.should be_an_instance_of(Hash)

      organized_entries.keys.should include(2010)
      organized_entries.keys.should include(2011)
      organized_entries.keys.should include(2012)

      organized_entries[2010][0][1].should include(@first_entry)
      organized_entries[2011][0][1].should include(@second_entry)
      organized_entries[2012][0][1].should include(@third_entry)
      organized_entries[2012][0][1].should_not include(@invisible_entry)
    end

    it "should generate a reverse-sorted list of the unique years encompassed by the inspiration_entries" do
      years = Spree::InspirationEntry.years

      years.should be_an_instance_of(Array)
      years.should == [2012, 2011, 2010]
    end

    it "should generate a numeric list of the months that contain inspiration_entries for a given year" do
      months_one = Spree::InspirationEntry.months_for(2010)
      months_two = Spree::InspirationEntry.months_for(2011)
      months_three = Spree::InspirationEntry.months_for(2012)

      months_one.should be_an_instance_of(Array)
      months_two.should be_an_instance_of(Array)
      months_three.should be_an_instance_of(Array)

      months_one.first.should == 1
      months_two.first.should == 2
      months_three.first.should == 3
    end
  end

  context "with a InspirationEntry created late in the day on 2/28/2010" do
    before do
      @entry = create(:inspiration_entry, :published_at => Time.zone.parse('2010-02-28 21:00:00'))
    end

    it "should retrieve given entry when queried for February entries" do
      date = DateTime.new(2010, 2)
      entries = Spree::InspirationEntry.by_date(date, :month)
      entries.should include(@entry)
    end
  end

  it "should populate published_at date when created" do
    @inspiration_entry = create(:inspiration_entry, :published_at => nil, :visible => false)
    @inspiration_entry.published_at.should_not be_nil
  end
end
