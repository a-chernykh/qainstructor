module Services

  class PurchaseCourse
    include Base

    def initialize(user:, course:, email:, token:)
      @user = user
      @course = course
      @email = email
      @token = token
    end

    def call
      if !@user.purchased_courses.include?(@course)
        begin
          customer_id = get_or_create_customer
          Stripe::Charge.create(
            customer: customer_id,
            amount: order.adjusted_price,
            description: @course.name,
            currency: 'usd'
          )
          @user.update_attributes!(stripe_customer_id: customer_id)
          @user.purchased_courses << @course
          @user.purchases.create!(course: @course, charge_cents: order.adjusted_price)
        rescue Stripe::CardError => e
          errors << e.message
        end
      else
        errors << 'You already own this course'
      end
    end

    private

    def order
      CourseOrder.new(course: @course, user: @user)
    end

    def get_or_create_customer
      if @user.stripe_customer_id
        @user.stripe_customer_id
      else
        customer = Stripe::Customer.create(email: @email, source: @token)
        customer.id
      end
    end
  end

end
