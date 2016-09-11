class CourseOrder
  def initialize(course:, user:)
    @course = course
    @user = user
  end

  def full_price
    @course.price_cents
  end

  def adjusted_price
    (full_price - (discount / 100.to_f) * full_price).to_i
  end

  def discounted?
    full_price > adjusted_price
  end

  private

  def discount
    if @user
      [@user.coupons.where(course: @course).sum(:discount_percent), 100].min
    else
      0
    end
  end
end
