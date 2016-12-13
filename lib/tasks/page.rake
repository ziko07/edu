include Rails.application.routes.url_helpers

namespace :page do
  desc 'Generate course category'

  task :general => :environment do
    SeoPage.create!(meta_title: 'Bear the music', meta_description: 'Bear the music', controller: 'welcome', action: 'index', url: '/')
    SeoPage.create!(meta_title: 'Browse courses', meta_description: 'Browse courses', controller: 'welcome', action: 'index', url: courses_path)
  end

  task :category => :environment do
    Category.all.each do |category|
      SeoPage.create!(meta_title: "Course Category - #{category.title}", meta_description: category.title, controller: 'courses', action: 'category_courses', url: category_courses_path(category))
    end
  end

  task :published_course => :environment do
    courses = Course.joins(:course_status).where('course_statuses.name = ?', AppData::COURSE_STATUS[:published])
    courses.each do |course|
      SeoPage.create!(meta_title: "Course - #{course.title}", meta_description: course.title, controller: 'courses', action: 'show', url: show_course_path(course))
    end
  end

end
