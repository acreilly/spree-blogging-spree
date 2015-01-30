Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :inspiration_entries
  end

  scope Spree::Config['inspiration_alias'], as: 'inspiration' do
    get '/tag/:tag' => 'inspiration_entries#tag', :as => :tag
    get '/category/:category' => 'inspiration_entries#category', :as => :category
    get '/:year/:month/:day/:slug' => 'inspiration_entries#show', :as => :entry_permalink
    get '/:year(/:month)(/:day)' => 'inspiration_entries#archive', :as => :archive,
      :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}
    get '/feed' => 'inspiration_entries#feed', :as => :feed, :format => :rss
    get '/' => 'inspiration_entries#index'
  end
end

