# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# open csv file
# read each row as an array
# create users
# create task 
# create task category with task_id and category_id

require 'populate'
require 'category_seed'

CategorySeed.all
Populate.all 

