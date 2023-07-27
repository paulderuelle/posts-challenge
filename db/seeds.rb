require 'faker'

Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "Generating new seeds..."

10.times do
  User.create!(
    nickname: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

users = User.all

50.times do
  post = Post.create!(
    user: users.sample,
    title: Faker::Lorem.sentence(word_count: 5),
    content: Faker::Lorem.sentence(word_count: 200),
    url: Faker::Internet.url
  )

  post.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'papernews.jpg')), filename: 'photo.jpg')


  rand(2..8).times do
    Comment.create!(
      user: users.sample,
      post: post,
      content: Faker::Lorem.sentence(word_count: 33)
    )
  end
end

puts "DB succesfully seeded"
