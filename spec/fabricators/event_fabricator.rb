Fabricator(:event) do
  description { Faker::Lorem.paragraph(2) }
  published_on { Date.today }
end