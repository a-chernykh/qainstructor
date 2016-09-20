class CourseOrder
  def initialize(course:, user:)
    @course = course
    @user = user
  end

  def full_price
    @course.price_cents
  end

  def adjusted_price
    (full_price - discount).to_i
  end

  def discounted?
    full_price > adjusted_price
  end

  private

  def discount
    if @user
      coupons = @user.coupons.where(course: @course)

      percent = coupons.sum(:discount_percent)
      cents = coupons.sum(:discount_cents)

      if cents > 0
        return [cents, full_price].min
      elsif percent > 0
        return [(percent.to_f / 100.to_f) * full_price, full_price].min
      end
    end

    0
  end
end
