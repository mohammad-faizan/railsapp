module PersonHelper
  def display_people_table(collection)
    thead = ["S.No.", "Name", "Email", "DOB", "Experience", "Skills"]
    thead = content_tag :thead, class: "thead-dark" do
      content_tag :tr do
        thead.collect {|h| concat content_tag(:th, h)}.join.html_safe
      end
    end

    tbody = content_tag :tbody do
      collection.each_with_index do |p, i|
        concat get_person_tr(p, i)
      end
    end
    table = content_tag :table, thead.concat(tbody), class: 'table'
  end

  def get_person_tr(p, i)
    content_tag :tr do
      concat content_tag(:td, (i+1))
      concat content_tag(:td, p.name)
      concat content_tag(:td, p.email)
      concat content_tag(:td, p.dob)
      concat content_tag(:td, p.experience)
      concat content_tag(:td, p.skills.map{|s| s.skill_name}.join(' '))
    end
  end
end
