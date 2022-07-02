module PeopleHelper

  include PaginateHelper

  def display_people_table(collection, collection_type, page)
    thead = ['S.No.', 'Name', 'Email', 'DOB', 'Experience', 'Skills', '', 'Options', '']
    fields = ['name', 'email', 'dob', 'experience', 'skills_as_string']

    offset = get_pagination_offset(page)

    if collection_type.to_s.downcase == 'employee'
      thead.delete('DOB')
      fields.delete('dob')
    end

    thead = content_tag :thead, class: "thead-dark" do
      content_tag :tr do
        thead.collect {|h| concat content_tag(:th, h)}.join.html_safe
      end
    end

    tbody = content_tag :tbody do
      collection.each_with_index do |p, i|
        concat get_person_tr(p, (i + 1), fields, offset)
      end
    end
    table = content_tag :table, thead.concat(tbody), class: 'table'
  end

  def get_person_tr(p, i, fields, offset)
    content_tag :tr do
      concat content_tag(:td, (offset + i))
      fields.collect {|f| concat content_tag(:td, p.send(f))}
      concat content_tag(:td, link_to("View", person_path(p, type: p.class), class: "btn btn-primary"))
      concat content_tag(:td, link_to("Update", edit_person_path(p), class: "btn btn-secondary"))
      concat content_tag(:td, link_to("Delete", person_path(p), data: {method: :delete, remote: true, confirm: 'Are you sure ?'}, class: "btn btn-danger btn-delete"))
    end
  end
end
