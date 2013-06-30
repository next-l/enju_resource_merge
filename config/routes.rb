Rails.application.routes.draw do
  resources :agents do
    resources :agent_merges
    resources :agent_merge_lists
  end
  resources :agent_merge_lists do
    resources :agents
    resources :agent_merges
  end
  resources :agent_merges

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
