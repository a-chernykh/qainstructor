module Services
  RSpec.describe PurchaseCourse do
    let(:user) { create(:user) }
    let(:course) { create(:course, price_cents: 3900) }

    subject { described_class.new(user: user,
                                  course: course,
                                  email: 'andrey@qainstructor.com',
                                  token: 'tok_17QrxBGevQFxhd9E3Aa8lrrE') }

    describe '#call' do
      before do
        customer = double(id: 'cus_7gEmv3BmnepUDf')
        allow(Stripe::Customer).to receive(:create).and_return(customer)
        allow(Stripe::Charge).to receive(:create)
      end

      it 'does nothing if user already owns course' do
        create(:user_course, user: user, course: course)
        expect(Stripe::Customer).not_to receive(:create)
        expect(Stripe::Charge).not_to receive(:create)
        subject.call
      end

      it 'does not create new Stripe Customer if user already has one' do
        user.update_attributes! stripe_customer_id: 'cus_7gEmv3BmnepUDf'
        expect(Stripe::Customer).not_to receive(:create)
        subject.call
      end

      it 'creates new Stripe Customer', :vcr do
        expect(Stripe::Customer).to receive(:create)
          .with(email: 'andrey@qainstructor.com', source: 'tok_17QrxBGevQFxhd9E3Aa8lrrE')
          .and_call_original
        subject.call
      end

      it 'creates new Stripe Charge', :vcr do
        expect(Stripe::Charge).to receive(:create)
          .with(customer: 'cus_7gEmv3BmnepUDf', amount: 3900, description: course.name, currency: 'usd')
          .and_call_original
        subject.call
      end

      it 'saves Customer id' do
        subject.call
        expect(user.reload.stripe_customer_id).to eq 'cus_7gEmv3BmnepUDf'
      end

      it 'unlocks the course' do
        subject.call
        expect(user.purchased_courses).to include(course)
      end

      it 'saves Purhcase record' do
        subject.call
        purchase = user.purchases.first!

        expect(purchase.course).to eq course
        expect(purchase.charge_cents).to eq 3900
      end

      it 'does not unlock the course if purchase was failed' do
        allow(Stripe::Charge).to receive(:create).and_raise(Stripe::CardError.new(1, 2, 3))
        subject.call
        expect(user.purchased_courses).not_to include(course)
      end
    end
  end
end
