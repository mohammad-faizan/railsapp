module PaginateHelper

  def get_pagination_offset(page)
    page = 1 unless page
    per_page = Globals::KAMINARI_DEFAULT_PER_PAGE
    ((page.to_i - 1) * per_page)
  end

end