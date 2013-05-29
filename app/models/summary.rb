
class Summary < Prawn::Document
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::UrlHelper
  
  attr_reader :answer_store, :request
  
  def initialize(request, answer_store = nil)
    super(:page_size => 'A4')
    default_font
    @request = request
    if answer_store
      @answer_store = answer_store
      display_header
      display_matching_rules
      display_answers
      display_warnings
      display_link_to_restore
    else
      display_no_answers
    end
  end
  
  private 
  def display_no_answers
    text "You have not answered any questions"
  end
  
  def display_matching_rules
    span_with_space_before do
      h2_font
      text "Recommendations"
      default_font
      text "Based on your answers, the following was suggested:"
    end
    rule_sets.each do |rule_set|
      indented_span do
        h3_font
          text(
            rule_set.title
          )

        default_font
        text(
          convert_html(rule_set.description)
        ) if rule_set.description
        
        text(
          link_to(rule_set.link_text? ? "#{rule_set.link_text} (click to view)" : rule_set.url, rule_set.url),
          :color => "0000FF",
          :inline_format => true 
        ) if rule_set.url
      end
    end
  end
  
  def display_answers
    span_with_space_before do
      h2_font
      text "The answers you submitted"
    end
    default_font
    move_down 5
    header = %w{Question Answer}
    data = answer_store.answers.collect{|a| [a.question.title, a.value]}
    data = [header] + data
    table data, :header => true
  end
  
  def display_header
    image image_path("WorkingForWarwickshireLogoSmall.png"), :at => [360, (cursor - 20)]
    image image_path("wcc_logo2005.png"), :position => :center

    span_with_space_before(0) do
      move_down 20
      h1_font
      text "Warwickshire County Council: Online Self Support", :align => :center
      default_font
      move_down 5
      text "Your on-line self-support details as recorded at #{Time.now.to_s(:datetime)}"
    end
  end
  
  def image_path(filename)
    "#{Rails.root}/app/assets/images/#{filename}"
  end
  
  def display_warnings
    ominous_warnings = request.session["ominous_warnings"]
    unless ominous_warnings.empty?
      move_down 20
      h1_font
      text "Warnings"
      default_font
      move_down 5
      ominous_warnings.each do |name, status|
        warning = Ominous::Warning.find_by_name(name)
        h2_font 
        text warning.title
        default_font
        text "This warning has#{ ' not' if  status.to_s == 'show' } been accepted.", :style => :italic
        text convert_html(warning.description)
        warning.closers.each do |closer|
          next if closer.start_hidden?
          text convert_html(closer.message)
        end
      end
    end
  end
  
  def display_link_to_restore
    span_with_space_before(25) do
      h1_font
      text "Return to questionnaire"
      default_font
      text "Use the link below to return to the self assessment site with these answers."
    end
    indented_span do
      port = request.port.to_i == 80 ? nil : ":#{request.port}"
      url = "#{request.protocol}#{request.host}#{port}/answer_stores/#{@answer_store.session_id}"
      text(
        link_to(url, url),
        :color => "0000FF",
        :inline_format => true 
      )
    end
  end
  
  def rule_sets
    Qwester::RuleSet.matching(answer_store.answers)
  end
  
  def default_font_size
    12
  end
  
  def default_space_between_boxes
    15
  end
  
  def default_indent
    15
  end
  
  def h1_font
    use_font :size => (default_font_size + 6), :style => :bold
  end
  
  def h2_font
    use_font :size => (default_font_size + 2), :style => :bold
  end
  
  def h3_font
    use_font :size => (default_font_size + 2)
  end
  
  def span_with_space_before(before = default_space_between_boxes)
    move_down before
    span(bounds.width) { yield }
  end
  
  def indented_span
    width = bounds.width - (2 * default_indent)
    move_down default_space_between_boxes 
    span(width, :position => :center) { yield }
  end
  
  def default_font
    use_font
  end
  
  def use_font(options = {})
    options[:size] ||= default_font_size
    font("Helvetica", options)
  end
  
  def convert_html(html)
    CGI::unescapeHTML strip_tags(html)
  end
  
end
