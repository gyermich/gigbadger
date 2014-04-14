# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'User'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end

badges = [
{id: 1,name: 'just-registered',description: "Just Registered", custom_fields: { image: '/profile.jpg' }},
{id: 2,name: 'task-completed',description: "Task Completed", custom_fields: { image: '/profile.jpg' }},
{id: 3,name: 'first-task-posted',description: "First Task Posted", custom_fields: { image: '/profile.jpg' }},
{id: 4,name: 'first_task-completed',,description: "First Task Completed", custom_fields: { image: '/profile.jpg' }},
{id: 5,name: '5th-task-completed',,description: "5th Task Completed", custom_fields: { image: '/profile.jpg' }},
{id: 6,name: '10th-task-completed',,description: "10th Task Completed", custom_fields: { image: '/profile.jpg' }},
]
badges.each do |badge|
  Merit::Badge.create!(badge)
end


