# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Post.destroy_all
Comment.destroy_all if defined?(Comment)

names = [
  "John Doe", "Jane Smith", "Alice Johnson", "Bob Brown", "Charlie Davis",
  "David Miller", "Emily Wilson", "Frank Moore", "Grace Taylor", "Helen Clark"
]

names.each_with_index do |name, index|
  User.create!(
    full_name: name,
    email: "#{name.split(' ').first.downcase}.#{name.split(' ').last.downcase}@example.com",
    password: "password",
    password_confirmation: "password",
    avatar_url: "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI="
  )
end

puts "Seeded #{User.count} users"

fake_posts = [
  {
    title: 'Child reduce growth first pick next.',
    content: 'American reality pull. Involve defense care newspaper political lead end. Today leg development page quite. Type close I couple enough issue consumer. Artist career sure open end team however.',
    author: 'Judith Miller'
  },
  {
    title: 'Red little mouth benefit catch.',
    content: 'End address truth none civil bed. Discover movie top street price politics consider. Talk history Congress window feel. Parent green really every standard.',
    author: 'Jessica Harris'
  },
  {
    title: 'Father note institution lead.',
    content: 'Now country recently. Paper find four. Also name expect baby red seek.',
    author: 'Natasha Smith'
  },
  {
    title: 'Hot hear how sing.',
    content: 'Town leave hot kitchen. Court of along church court very company. Least could house. Believe marriage seven idea business sport according. Impact build investment fall could memory purpose. Role reduce plan country glass floor such. Detail them think financial staff recognize.',
    author: 'Tracy Walker'
  },
  {
    title: 'Most then but if billion less technology.',
    content: 'Art image century who. Agent next even quickly suddenly everyone. Daughter door his. Call ability model beautiful figure. Go save parent test that beautiful receive. Pay big bill might.',
    author: 'Beth Flores'
  },
  {
    title: 'Onto usually consumer mission.',
    content: 'Magazine professional know main before. Party deep coach newspaper important stuff. Of cover himself view. Still environmental station affect. Home police growth wrong know specific sea.',
    author: 'Daniel Gomez'
  },
  {
    title: 'Reveal finally third drop.',
    content: 'Send technology soon. Speech just study miss according pass they. Where major travel listen nothing worker enough.',
    author: 'Michael Richardson'
  },
  {
    title: 'Example I writer back word try.',
    content: 'Cultural above although both sign traditional. Participant in church available. Soon simply level indeed difficult fish. Language election site although despite purpose.',
    author: 'Donna Delgado'
  },
  {
    title: 'Exist quite air need letter spring case law.',
    content: 'Suddenly may personal blood position list. Individual mouth during establish statement forget a. Age former carry happen try even. Sit by plant amount model star.',
    author: 'Rose Michael'
  },
  {
    title: 'Understand current hundred continue seem fund.',
    content: 'Plant wait argue relationship away find term role. Phone rather image. May and note hot side like member. See sense several deep ground eye.',
    author: 'Eduardo Scott'
  },
  {
    title: 'Method ever water.',
    content: 'Left customer new. Able all power way significant drop direction. Lead until quality into particularly. Center phone media job. Hospital coach clearly member lawyer friend.',
    author: 'Miss Brittany Garcia MD'
  },
  {
    title: 'Technology black care affect career again style.',
    content: 'Human series another parent. But you side land rate machine low training. Road tax response view to. Own sell strong return minute threat. Foot candidate early job finish.',
    author: 'Dr. Lance Avila'
  },
  {
    title: 'Election decade final first whom.',
    content: 'Worker well industry administration cause. Hear cost effort middle trip black. Style major accept after affect expert.',
    author: 'Sarah Hernandez'
  },
  {
    title: 'Give this society rise research.',
    content: 'Story peace performance physical. Bar cultural son thing performance. Professor case politics across media figure actually night. In guy attention technology different.',
    author: 'Shane Williams'
  },
  {
    title: 'Campaign several treatment seek hour.',
    content: 'Shake though role Democrat military live. Side rock somebody. Week deal plant admit trip out even. Group cold who with reduce arrive. Live number region seat outside probably.',
    author: 'Ariana Perry'
  },
  {
    title: 'Next job leg employee.',
    content: 'Attorney relate bar scene high quite. Central himself Republican off would. Every thousand example attack. Production window drop affect data occur. Somebody option star any. Age yeah start edge door popular. Grow role land five.',
    author: 'Julia Burch'
  }
]

fake_posts.each do |post|
  User.all.sample.posts.find_or_create_by!(title: post[:title], body: post[:content], image_url: "https://picsum.photos/600/300")
end

puts "Seeded #{Post.count} posts"