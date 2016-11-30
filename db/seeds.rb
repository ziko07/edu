# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.delete_all
Category.create!(title: 'Guitar', image: File.open(File.join(Rails.root, '/app/assets/images/guitar.jpg')), position: 1)
Category.create!(title: 'Music Business', image: File.open(File.join(Rails.root, '/app/assets/images/music_business.jpg')), position: 2)
Category.create!(title: 'Music Production', image: File.open(File.join(Rails.root, '/app/assets/images/music_production.jpg')), position: 3)
Category.create!(title: 'Percussion', image: File.open(File.join(Rails.root, '/app/assets/images/percussion.jpg')), position: 4)
Category.create!(title: 'Piano', image: File.open(File.join(Rails.root, '/app/assets/images/piano.jpg')), position: 5)
Category.create!(title: 'Play By Ear', image: File.open(File.join(Rails.root, '/app/assets/images/play_by_ear.jpg')), position: 6)
Category.create!(title: 'Songwriting', image: File.open(File.join(Rails.root, '/app/assets/images/song_writing.jpg')), position: 7)
Category.create!(title: 'Strings', image: File.open(File.join(Rails.root, '/app/assets/images/strings.jpg')), position: 8)
Category.create!(title: 'Ukulele', image: File.open(File.join(Rails.root, '/app/assets/images/ukulele.jpg')), position: 9)
Category.create!(title: 'Woodwind & Brass', image: File.open(File.join(Rails.root, '/app/assets/images/woodwind.jpg')), position: 10)
Category.create!(title: 'Singing', image: File.open(File.join(Rails.root, '/app/assets/images/singing_lessons.jpg')), position: 11)
# User.delete_all

# CourseStatus.create!(name: 'pending review')
# CourseStatus.create!(name: 'published')
# CourseStatus.create!(name: 'rejected')
# CourseStatus.create!(name: 'unpublished')

