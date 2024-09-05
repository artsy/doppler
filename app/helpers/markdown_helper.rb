module MarkdownHelper
  def render_markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, tables: true)
    doc = Nokogiri::HTML::DocumentFragment.parse(renderer.render(text))
    doc.css("code[@class]").each do |code|
      case code[:class]
      when /(?<class>\w*)\[(?<type>\w*)\]/
        code["class"] = "#{$LAST_MATCH_INFO["class"]} #{$LAST_MATCH_INFO["class"]}-#{$LAST_MATCH_INFO["type"]}"
        code.name = "div"
        code.parent.swap(code)
        code.inner_html = render_markdown(code.inner_html)
      else
        div = highlight_syntax(code.text.rstrip, code[:class].to_sym)
        code = code.replace(div)
        code.first.parent.swap(code.first)
      end
    end
    doc.search("table").each do |table|
      table["class"] = "table table-bordered table-striped"
    end
    doc.to_s
  end

  def highlight_syntax(text, format)
    CodeRay.scan(text.rstrip, format).div
  end
end
