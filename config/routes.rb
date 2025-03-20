Pub::Sub::Engine.routes.draw do
  resources :topics, only: :show do
    resources :subscriptions, shallow: true, only: [ :create, :destroy ]
    resources :messages, only: :create
  end

  # The admin creates the:
  # - topic
  # - client
  # - key

  # The system creates the:
  # - deliveries.
end
