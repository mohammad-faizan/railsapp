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

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "text-end add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
