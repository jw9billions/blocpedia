module ApplicationHelper
  # https://www.youtube.com/watch?v=vPW6t-r0xzM

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :fenced_code_blocks, :highlight]
    Redcarpet.new(text, *options).to_html.html.safe
  end
end
