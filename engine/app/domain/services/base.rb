module Services

  module Base
    extend ActiveSupport::Concern

    class_methods do
      def call(*args)
        new(*args).call
      end
    end

    def errors
      @errors ||= []
    end

    def valid?
      errors.empty?
    end
  end

end
