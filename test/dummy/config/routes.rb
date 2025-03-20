Rails.application.routes.draw do
  mount Pub::Sub::Engine => "/pub-sub"

  match 'pub-sub-failure-callback', to: 'pub_sub_callback#respond_with_failure', via: [:post]
  match 'pub-sub-success-callback', to: 'pub_sub_callback#respond_with_success', via: [:post]
end
