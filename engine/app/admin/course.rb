ActiveAdmin.register Course do
  permit_params :name

  sidebar 'Course Details', only: [:show, :edit] do
    ul do
      li link_to 'Chapters', admin_course_chapters_path(course)
    end
  end
end
