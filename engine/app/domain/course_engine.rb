class CourseEngine
  attr_accessor :user

  def initialize(user:, course:)
    @user = user
    @course = course
  end

  def purchased?
    if @purchased.nil?
      @purchased = @user.purchased_courses.include?(@course)
    end
    @purchased
  end

  def started?
    user_completions
      .where(completable: @course.chapters)
      .any?
  end

  def current
    scope = if purchased?
              @course.chapters
            else
              @course.chapters.demo
            end
    scope
      .where.not(id: completed_chapters)
      .order(:position)
      .first
  end

  def start_chapter(chapter)
    user_completions.where(completable: chapter).first_or_create! do |uc|
      uc.started_at = Time.now.utc
    end
  end

  def finish_chapter(chapter)
    uc = start_chapter(chapter)
    uc.update_attributes! completed_at: Time.now unless uc.completed_at?
    start_chapter(current) if current
  end

  def chapter_status(chapter)
    completion = user_completions.find { |uc| uc.completable == chapter }
    if completion.nil?
      :not_started
    elsif completion.completed_at?
      :completed
    else
      :started
    end
  end

  def chapter_available?(chapter)
    status = chapter_status(chapter)
    [:completed, :started].include?(status)
  end

  def progress
    chapters_count = @course.chapters.count
    completed_chapters_count = completed_chapters.count

    (completed_chapters_count / chapters_count.to_f * 100).to_i
  end

  private

  def user_completions
    @user_completions ||= @user.user_completions.includes(:completable)
  end

  def completed_chapters
    @course.chapters
      .joins(:user_completions)
      .where('user_completions.user_id = ?', @user.id)
      .merge(UserCompletion.completed)
  end
end
