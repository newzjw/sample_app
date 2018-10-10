Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  #root to: 'static_pages#home'
  get 'static_pages/home'

  get 'static_pages/help' #会生成static_pages_help_path方法
  #match '/help', to: 'static_pages#help', via: 'get' #具名路由,会生成help_path方法

  get 'static_pages/about'
  get 'static_pages/contact'

  #about_path -> '/about'
  #about_url -> 'http://localhost:3000/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
