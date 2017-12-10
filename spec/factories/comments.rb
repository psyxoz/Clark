FactoryBot.define do
  factory :comment do
    article
    user
    content { Forgery::LoremIpsum.sentence }
  end
end
