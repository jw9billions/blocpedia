module ApplicationHelper
  # https://www.youtube.com/watch?v=vPW6t-r0xzM
  # https://github.com/tadeosss/blocipedia/commit/511f6357cd7a10eae8a2de211bcdf0e010a5990a
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :fenced_code_blocks, :highlight]
    Redcarpet.new(text, *options).to_html.html.safe
  end
end
