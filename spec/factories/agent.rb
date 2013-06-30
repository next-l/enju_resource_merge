FactoryGirl.define do
  factory :agent do |f|
    f.sequence(:full_name){|n| "full_name_#{n}"}
  end
end

FactoryGirl.define do
  factory :invalid_agent, :class => Agent do |f|
  end
end
