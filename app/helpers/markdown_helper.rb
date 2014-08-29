module MarkdownHelper
  def render_markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, tables: true)
    doc = Nokogiri::HTML::DocumentFragment.parse(renderer.render(text))
    doc.css('code[@class]').each do |code|
      div = CodeRay.scan(code.text.rstrip, code[:class].to_sym).div
      code = code.replace(div)
      code.first.parent.swap(code.first)
    end
    doc.search('table').each do |table|
      table['class'] = 'table table-bordered table-striped'
    end
    doc.to_s
  end

  def highlight_syntax(text, format)
    CodeRay.scan(text.rstrip, format).div
  end
end
