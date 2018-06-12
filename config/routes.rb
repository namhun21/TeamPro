Rails.application.routes.draw do
  devise_for :users 
  root 'posts#show'    #'posts#index'  처음화면  
  get 'posts/mypage'
  
 
  
  resources :posts, except: [:show] do  #상세보기 제외한 나머지 기능들 구현
    post "/like", to: "likes#like_toggle"
    resources :comments, only: [:create, :destroy]
  end
  resources :follows, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
