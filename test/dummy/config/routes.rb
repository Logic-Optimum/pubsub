Rails.application.routes.draw do
  mount Pub::Sub::Engine => "/pub-sub"
end
