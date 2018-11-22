Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
	root to:'root#top'

	devise_for :users

	resources :users do
		get "history" => 'users#history'
	end
	resources :groups do
		resource :favorites, only: [:create, :destroy]
		resource :members, only: [:create, :destroy]
		post "/joins" => 'groups#join'
		get "/search/users" => "groups#search"
		post "/search/users/:search_user_id/invites" => 'groups#invite'

	end
	resources :recipes do
		resource :keeps, only: [:create, :destroy]
		resources :steps, only: [:create, :edit, :update, :destroy]#コクーン
		resources :materials, only:[:create, :edit, :update, :destroy]#コクーン
		post "count" => 'recipes#count'
	end
	resources :categories, only: [:index,:show, :create, :update, :destroy, :edit]
	resources :units, only: [:index, :create, :update, :destroy, :edit]#materialにセレクトボックスで選択
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
