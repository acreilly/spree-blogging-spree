class Spree::InspirationEntriesController < Spree::StoreController
  helper 'spree/inspiration_entries'

  before_filter :init_pagination, :only => [:index, :tag, :archive, :category]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    @inspiration_entries = Spree::InspirationEntry.visible.page(@pagination_page).per(@pagination_per_page)
  end

  def show
    if try_spree_current_user.try(:has_spree_role?, "admin")
      @inspiration_entry = Spree::InspirationEntry.find_by_permalink!(params[:slug])
    else
      @inspiration_entry = Spree::InspirationEntry.visible.find_by_permalink!(params[:slug])
    end
    @title = @inspiration_entry.title
  end

  def tag
    @inspiration_entries = Spree::InspirationEntry.visible.by_tag(params[:tag]).page(@pagination_page).per(@pagination_per_page)
    @tag_name = params[:tag]
  end

  def category
    @inspiration_entries = Spree::InspirationEntry.visible.by_category(params[:category]).page(@pagination_page).per(@pagination_per_page)
    @category_name = params[:category]
  end

  def archive
    @inspiration_entries = Spree::InspirationEntry.visible.by_date(params).page(@pagination_page).per(@pagination_per_page)
  end

  def feed
    @inspiration_entries = Spree::InspirationEntry.visible.limit(20)
    render :layout => false
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
    end
end
