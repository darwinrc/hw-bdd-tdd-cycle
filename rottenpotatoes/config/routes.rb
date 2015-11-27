Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/find_with_same_director/:id', to: 'movies#find_with_same_director', as: 'find_with_same_director'
end
