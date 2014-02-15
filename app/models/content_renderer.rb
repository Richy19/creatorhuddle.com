
class ContentRenderer
  include AutoHtml

  def initialize(content, strip: false)
    @content = content
    @strip = strip
  end

  def render
    if @content.blank?
      ''
    else
      rendered_content = Sanitize.clean(@content, Sanitize::Config::RESTRICTED)
      rendered_content = auto_html(rendered_content) do
        youtube width: 400, height: 250
        vimeo width: 400, height: 250
        soundcloud theme_color: 'ffffff', color: '2F3841', show_artwork: true
      end

      markdown = Redcarpet::Markdown.new(get_markdown_renderer, autolink: true, space_after_headers: true)
      markdown.render(rendered_content).html_safe
    end
  end

  def get_markdown_renderer
    if @strip
      Redcarpet::Render::StripDown
    else
      Redcarpet::Render::HTML
    end
  end
end
