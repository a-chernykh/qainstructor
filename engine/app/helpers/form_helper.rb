module FormHelper
  def service_error_messages(errors)
    errors.each do |error|
      concat(content_tag(:div, error, class: "alert alert-danger") do
              concat error
            end)
    end
    nil
  end
end
