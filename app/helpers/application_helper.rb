module ApplicationHelper

  def glyph_chevron(orrientation)
    arrow = orrientation == 'asc' ? 'down' : 'up'
    "glyphicon glyphicon-chevron-#{arrow}"
  end

  def sort_params(sort_strategy)
    sort_strategy == 'asc' ? 'desc' : 'asc'
  end

end
