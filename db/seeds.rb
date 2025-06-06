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
Comment.destroy_all
FriendRequest.destroy_all

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
    content: 'American reality pull. Involve defense care newspaper political lead end. Today leg development page quite. Type close I couple enough issue consumer. Artist career sure open end team however.'
  },
  {
    title: 'Red little mouth benefit catch.',
    content: 'End address truth none civil bed. Discover movie top street price politics consider. Talk history Congress window feel. Parent green really every standard.'
  },
  {
    title: 'Father note institution lead.',
    content: 'Now country recently. Paper find four. Also name expect baby red seek.'
  },
  {
    title: 'Hot hear how sing.',
    content: 'Town leave hot kitchen. Court of along church court very company. Least could house. Believe marriage seven idea business sport according. Impact build investment fall could memory purpose. Role reduce plan country glass floor such. Detail them think financial staff recognize.'
  },
  {
    title: 'Most then but if billion less technology.',
    content: 'Art image century who. Agent next even quickly suddenly everyone. Daughter door his. Call ability model beautiful figure. Go save parent test that beautiful receive. Pay big bill might.'
  },
  {
    title: 'Onto usually consumer mission.',
    content: 'Magazine professional know main before. Party deep coach newspaper important stuff. Of cover himself view. Still environmental station affect. Home police growth wrong know specific sea.'
  },
  {
    title: 'Reveal finally third drop.',
    content: 'Send technology soon. Speech just study miss according pass they. Where major travel listen nothing worker enough.'
  },
  {
    title: 'Example I writer back word try.',
    content: 'Cultural above although both sign traditional. Participant in church available. Soon simply level indeed difficult fish. Language election site although despite purpose.'
  },
  {
    title: 'Exist quite air need letter spring case law.',
    content: 'Suddenly may personal blood position list. Individual mouth during establish statement forget a. Age former carry happen try even. Sit by plant amount model star.'
  },
  {
    title: 'Understand current hundred continue seem fund.',
    content: 'Plant wait argue relationship away find term role. Phone rather image. May and note hot side like member. See sense several deep ground eye.'
  },
  {
    title: 'Method ever water.',
    content: 'Left customer new. Able all power way significant drop direction. Lead until quality into particularly. Center phone media job. Hospital coach clearly member lawyer friend.'
  },
  {
    title: 'Technology black care affect career again style.',
    content: 'Human series another parent. But you side land rate machine low training. Road tax response view to. Own sell strong return minute threat. Foot candidate early job finish.'
  },
  {
    title: 'Election decade final first whom.',
    content: 'Worker well industry administration cause. Hear cost effort middle trip black. Style major accept after affect expert.'
  },
  {
    title: 'Give this society rise research.',
    content: 'Story peace performance physical. Bar cultural son thing performance. Professor case politics across media figure actually night. In guy attention technology different.'
  },
  {
    title: 'Campaign several treatment seek hour.',
    content: 'Shake though role Democrat military live. Side rock somebody. Week deal plant admit trip out even. Group cold who with reduce arrive. Live number region seat outside probably.'
  },
  {
    title: 'Next job leg employee.',
    content: 'Attorney relate bar scene high quite. Central himself Republican off would. Every thousand example attack. Production window drop affect data occur. Somebody option star any. Age yeah start edge door popular. Grow role land five.'
  }
]


fake_comments = [
  { content: 'Really interesting take. I hadn’t thought of it that way before.' },
  { content: 'The way you explained it made a lot of sense. Thanks for sharing!' },
  { content: 'Curious how this plays out in real-life scenarios.' },
  { content: 'I respectfully disagree. There are other factors to consider.' },
  { content: 'Nice insight. This helps clarify a few things I was stuck on.' },
  { content: 'I’d love to see a follow-up post on this topic!' },
  { content: 'Well-written and clearly thought out. Appreciate the detail.' },
  { content: 'I have a similar experience that supports this. Good read.' },
  { content: 'This sparked a good discussion in my class today.' },
  { content: 'What sources did you use for this? I want to dig deeper.' },
  { content: 'The comment about growth really stuck with me. Thanks!' },
  { content: 'Not sure I follow the logic in the second paragraph.' },
  { content: 'Very timely. I was just reading something similar in the news.' },
  { content: 'This makes a strong case for reevaluating current practices.' },
  { content: 'Can someone explain what the third sentence means?' },
  { content: 'You’ve captured the nuance really well here.' },
  { content: 'This reminds me of a conversation I had just last week.' },
  { content: 'It’s refreshing to see this perspective for once.' },
  { content: 'I think there’s room to dive even deeper into this.' },
  { content: 'I shared this with my team — sparked a good chat.' },
  { content: 'Wasn’t expecting that conclusion, but it makes sense.' },
  { content: 'Do you think this applies across industries?' },
  { content: 'I like how you broke it down step by step.' },
  { content: 'I learned something new — appreciate the insight!' },
  { content: 'This ties in well with something I read in HBR.' },
  { content: 'Have you considered doing a video version of this?' },
  { content: 'I think your examples could be even more concrete.' },
  { content: 'Reading this gave me an idea for a side project.' },
  { content: 'Looking forward to what you write about next.' },
  { content: 'There’s a lot to unpack here — bookmarking for later.' }
]

fake_replies = [
  { content: 'Totally agree with this.' },
  { content: 'That’s an interesting point!' },
  { content: 'Can you elaborate a bit more?' },
  { content: 'I had the same thought.' },
  { content: 'Thanks for pointing that out.' },
  { content: 'Yes, this is often overlooked.' },
  { content: 'Exactly what I was thinking.' },
  { content: 'Good question — I’d like to know too.' },
  { content: 'That’s a helpful perspective.' },
  { content: 'You made me rethink this.' },
  { content: 'I see where you’re coming from now.' },
  { content: 'Would love to hear more from you on this.' },
  { content: 'Could you share a source?' },
  { content: 'Interesting — never thought of it like that.' },
  { content: 'You summed it up perfectly.' },
  { content: 'Respectfully, I disagree.' },
  { content: 'This made me laugh 😄' },
  { content: 'Agreed. It’s spot on.' },
  { content: 'I’ve seen this in action and it’s true.' },
  { content: 'Mind if I quote you on that?' }
]

fake_posts.each do |post|
  User.all.sample.posts.find_or_create_by!(title: post[:title], body: post[:content], image_url: "https://picsum.photos/600/300")
end
puts "Seeded #{Post.count} posts"

fake_comments.each do |comment|
  user = User.all.sample
  post = Post.all.sample
  parent_comment = user.comments.find_or_create_by(body: comment[:content], commentable_type: "Post", commentable_id: post.id, parent_id: nil)

  rand(0..2).times do
    reply_user = User.all.sample
    reply_content = fake_replies.sample[:content]

    reply_user.comments.find_or_create_by!(
      body: reply_content,
      commentable_type: "Post",
      commentable_id: post.id,
      parent_id: parent_comment.id
    )
  end
end

puts "Seeded #{Comment.count} comments"


User.all.each do |user1|
  User.all.each do |user2|
    unless user1 == user2
      FriendRequest.find_or_create_by(user_id: user1.id, friend_id: user2.id, status: 1)
    end  
  end
end

puts "Seeded #{FriendRequest.count} friendships"