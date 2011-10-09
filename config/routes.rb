Rails.application.routes.draw do
  resources :patrons do
    resources :patron_merges
    resources :patron_merge_lists
  end
  resources :patron_merge_lists do
    resources :patrons
    resources :patron_merges
  end
  resources :patron_merges

  resources :series_statements do
    resources :series_statement_merges
    resources :series_statement_merge_lists
  end
  resources :series_statement_merge_lists do
    resources :series_statements
    resources :series_statement_merges
  end
  resources :series_statement_merges
end
