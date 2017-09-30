
module ApplicationHelper

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      space_after_headers: true,
      link_attributes: {rel: 'nofollow', target: "_blank" },
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      highlight: true,
      strikethrough: true,
      underline: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe

  end
=begin
  # https://www.youtube.com/watch?v=vPW6t-r0xzM

  def markdown(text)
    #options = {:hard_wrap, :filter_html, :autolink, :fenced_code_blocks, :highlight}
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer)

    markdown.render(text).html_safe
    #Redcarpet.new(text, *options).to_html.html.safe
  end
=end

end
