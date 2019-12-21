FactoryBot.define do
  factory :person_dependent do
    person { build{ :person } }
    dependent { build{ :specie } }    
  end
end
