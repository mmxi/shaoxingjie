module ApplicationHelper
  def render_bcs
    output = '<div class="breadcrumb">'
    content_tag :div, :class => "breadcrumb" do
      render_breadcrumbs :separator => '<span class="divider">/</span>'
    end
  end
end
