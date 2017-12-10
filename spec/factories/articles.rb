FactoryBot.define do
  factory :article do
    user
    sequence(:title) { |n| "Title #{n}" }
    content { Forgery::LoremIpsum.paragraph }

    factory :article_with_comments do
      ignore do
        comments_count 3
      end

      after(:create) do |article, evaluator|
        create_list(:comment, evaluator.comments_count, article: article)
      end
    end
  end
end
