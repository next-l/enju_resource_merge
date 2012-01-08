FactoryGirl.define do
  factory :patron do |f|
    f.sequence(:full_name){|n| "full_name_#{n}"}
  end
end

FactoryGirl.define do
  factory :invalid_patron, :class => Patron do |f|
  end
end
