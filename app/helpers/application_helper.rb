module ApplicationHelper
  def form_errors(model)
    if model.errors.any?
      content_tag :ul do
        model.errors.full_messages.each do |e|
          concat content_tag(:li, e, class: "text-danger")
        end
      end
    end
  end
end
