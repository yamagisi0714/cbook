Rails.application.routes.draw do
	root to:'top#top'
	devise_for :users, controllers: {
	sessions:      'users/sessions',
	passwords:     'users/passwords',
	registrations: 'users/registrations'
}
	resources :users, only:[:index, :show, :edit, :update, :destroy] do
		member do
     		get :following, :followers
	    end
  	end
  	resources :relationships, only: [:create, :destroy]
	resources :groups, only:[:index, :new, :show, :edit, :update, :destroy]
	resources :recipes do
		resource :keeps, only: [:create, :destroy]
		resources :steps, only:[:create, :edit, :update, :destroy]#コクーン
		resources :materials, only:[:create, :edit, :update, :destroy]#コクーン
	end
	resources :categories, only:[:index,:show, :create, :update, :destroy, :edit]
	resources :units, only:[:index, :create, :update, :destroy, :edit]#materialにセレクトボックスで選択
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
