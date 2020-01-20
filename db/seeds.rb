# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

users = User::ROLES.each_with_object([]) do |role, memo|
  user = User.create!(
    role: role,
    email: "#{role}@clark.de",
    password: 'password',
    password_confirmation: 'password'
  )

  10.times do
    user.articles.create!(
      title: Forgery::LoremIpsum.title,
      content: Forgery::LoremIpsum.paragraph
    )
  end

  memo << user
end

Article.find_each do |article|
  20.times do
    article.comments.create!(
      user: users.sample,
      content: Forgery::LoremIpsum.paragraph
    )
  end
end
