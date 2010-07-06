ActionController::Routing::Routes.draw do |map|
  map.resources :projects, :member => {:add_user => :post, :remove_user => :post, :add_attachment => :post} do |project|
    project.resources :tasks
    project.tag 'tag/:tag', :controller => 'projects', :action => 'tag'
    project.user 'user/:id', :controller => 'projects', :action => 'user'
  end

  map.my_tasks '/my', :controller => 'tasks', :action => 'my_tasks'
  map.resources :tasks, :member => {:close => :get, :open => :get, :comment => :post}
  map.resources :uploads, :only => [:create, :destroy]
  map.devise_for :users

  map.root :controller => 'projects'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
