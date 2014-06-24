Fabricator(:user) do
  email     { Faker::Internet.email }
  password  'secret'
  full_name { Faker::Name.name }
  admin false
  active true
end

Fabricator(:admin, from: :user) do
  admin true
end