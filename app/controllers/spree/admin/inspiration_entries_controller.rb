class Spree::Admin::InspirationEntriesController < Spree::Admin::ResourceController
  helper 'spree/inspiration_entries'


  private

    def location_after_save
      edit_admin_inspiration_entry_url(@inspiration_entry)
    end

    def collection
      page = params[:page].to_i > 0 ? params[:page].to_i : 1
      per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
      model_class.page(page).per(per_page)
    end

end
