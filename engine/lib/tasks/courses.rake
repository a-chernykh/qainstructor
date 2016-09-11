namespace :courses do
  task :unlock_chapters, [:course_code, :email] => :environment do |t, args|
    course = Course.find_by_code!(args[:course_code])
    user = User.find_by_email!(args[:email])

    task = Tasks::Courses::UnlockChapters.new(course: course, user: user)
    task.run
  end
end
