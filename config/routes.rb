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
end
