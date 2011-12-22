module ApplicationHelper
  def render_bcs
    output = '<div class="breadcrumb">'
    content_tag :div, :class => "breadcrumb" do
      render_breadcrumbs :separator => '<span class="divider">/</span>'
    end
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
end
