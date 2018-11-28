Rails.application.routes.draw do
	root to:'root#top'

	devise_for :users

	resources :users do
		resource :mygroups, only: [:show, :destroy]#属しているグループもしくは招待されたグループ
		get "history" => 'users#history'#投稿したレシピ
		get "/stock" => 'users#stock'
	end
	resources :groups do
		resource :favorites, only: [:create, :destroy]
		post "/joins" => 'groups#join'#グループに参加する
		get "/search/users" => "groups#search"#招待するユーザーを検索
		post "/search/users/:search_user_id/invites" => 'groups#invite'#招待
		patch "approval" => 'mygroups#approval'#申請承認
		delete "withdrawal" => 'mygroups#withdrawal'#退会
		patch "/change/users/:user_id/status" => 'member#change'#メンバーのステータス変更
		delete "/ban/users/:user_id/ban_user" => 'member#ban'#強制退会
	end
	resources :recipes do
		resource :keeps, only: [:create, :destroy]#ストック
		resources :steps do #料理手順
			put :sort
		end
		resources :materials do#材料
			put :sort2
		end
		post "count" => 'recipes#count'#閲覧数
	end
	resources :categories, only: [:index,:show, :create, :update, :destroy, :edit]#料理のカテゴリー詳細ページの関連で使用
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
