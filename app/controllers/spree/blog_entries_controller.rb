class Spree::BlogEntriesController < Spree::StoreController
  helper 'spree/blog_entries'

  before_filter :init_pagination, :only => [:index, :tag, :archive, :category]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    @blog_entries = Spree::BlogEntry.visible.page(@pagination_page).per(@pagination_per_page)
  end

  def show
    if try_spree_current_user.try(:has_spree_role?, "admin")
      @blog_entry = Spree::BlogEntry.find_by_permalink!(params[:slug])
    else
      @blog_entry = Spree::BlogEntry.visible.find_by_permalink!(params[:slug])
    end
    @title = @blog_entry.title
  end

  def tag
    @blog_entries = Spree::BlogEntry.visible.by_tag(params[:tag]).page(@pagination_page).per(@pagination_per_page)
    @tag_name = params[:tag]
  end

  def category
    @blog_entries = Spree::BlogEntry.visible.by_category(params[:category]).page(@pagination_page).per(@pagination_per_page)
    @category_name = params[:category]
  end

  def archive
    @blog_entries = Spree::BlogEntry.visible.by_date(params).page(@pagination_page).per(@pagination_per_page)
  end

  def feed
    @blog_entries = Spree::BlogEntry.visible.limit(20)
    render :layout => false
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 9
    end
end
