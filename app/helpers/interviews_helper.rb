module InterviewsHelper
  include PaginateHelper

  def display_interviews_table(collection, page)
    thead = ["S.No.", "Candidate Name", "Interview Round(s)", "Average Rating", "", "Options", ""]
    thead = content_tag :thead do
      content_tag :tr do
        thead.collect {|h| concat content_tag(:th, h)}.join.html_safe
      end
    end

    offset = get_pagination_offset(page)

    tbody = content_tag :tbody do
      collection.each_with_index do |c, i|
        concat get_interview_tr(c, (i + 1), offset)
      end
    end
    table = content_tag :table, thead.concat(tbody), class: 'table'
  end

  def get_interview_tr(c, i, offset)
    content_tag :tr, scope: "row" do
      concat content_tag(:td, (offset + i))
      concat content_tag(:td, c.candidate.name)
      concat content_tag(:td, c.interview_rounds.size)
      concat content_tag(:td, c.average_ratings)
      concat content_tag(:td, link_to("View", interview_path(c), class: "btn btn-primary"))
      concat content_tag(:td, link_to("Update", edit_interview_path(c), class: "btn btn-secondary"))
      concat content_tag(:td, link_to("Delete", c, data: {method: :delete, remote: true, confirm: 'Are you sure ?'}, class: "btn btn-danger btn-delete"))
    end
  end
end
