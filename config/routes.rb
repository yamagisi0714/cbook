Rails.application.routes.draw do
	root to:'root#top'

	devise_for :users

	resources :users
	resources :groups
	resources :recipes do
		resource :keeps, only: [:create, :destroy]
		resources :steps, only: [:create, :edit, :update, :destroy]#コクーン
		resources :materials, only:[:create, :edit, :update, :destroy]#コクーン
	end
	resources :categories, only: [:index,:show, :create, :update, :destroy, :edit]
	resources :units, only: [:index, :create, :update, :destroy, :edit]#materialにセレクトボックスで選択
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
