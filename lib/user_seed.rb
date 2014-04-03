require 'csv'

class UserSeed

  def self.all
    CSV.read("./lib/badger.csv").map do |array|
      create_user(array)
    end
  end

  def self.create_user(user_array)
    user = User.create(
      name: user_array[0],
      email: user_array[1],
      city: user_array[2],
      zipcode: user_array[3],
      bio: user_array[4],
      password: Faker::Internet.password(8)
    )

    create_user_category(user, user_array)
  end

  def self.create_user_category(user, user_array)
    UserCategory.create(
      user_id: user.id,
      category_id: user_array[5]
      )
  end
end