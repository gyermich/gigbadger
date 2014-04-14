# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      grant_on 'users/registrations#create', badge: 'just-registered', model_name: 'User'

      grant_on 'tasks/complete', badge: 'first-task-completed', model_name: 'User'

      # If it has 10 comments, grant commenter-10 badge
      grant_on 'tasks#post', badge: 'first-task' do |task|
            Task.where(owner_id: task.owner.id).count == 1
      end

      grant_on 'tasks#complete', badge: 'first-task-completed', to: :workers, model_name: 'Task' do |task|

            task.users.each do |user|
                  user.tasks.count == 1
            end
      end

      # grant_on 'tasks#post', badge: 'second_task', model_name: "User" do |user|
      #   user.tasks.count == 2
      # end

      # grant_on 'tasks#post', badge: 'first-task',  to: :user do |user|
      #   # task.owner.tasks.count == 10
      #   Task.where(owner_id: user.id).count == 15
      end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end

      # badges = [
      # {id: 1,name: 'just-registered',image:"/images/registered.png",custom_fields:"Registered for an account"},
      # {id: 2,name: 'verified-user',image:"/images/verified-user.png",custom_fields:"Verified as a valid user" },
      # {id: 3,name: 'first-image',image:"/images/registered.png",custom_fields:"Uploaded first profile picture"},
      # {id: 4,name: 'first_vote',image:"/images/vote.png",custom_fields:"Voted for your first professor"},
      # {id: 5,name: 'autobiographer',image:"/images/biography.png",custom_fields:"Wrote a biography about yourself."}
      # ]
      # badges.each do |badge|
      #   Merit::Badge.create!(badge)
      # end
  end
end
