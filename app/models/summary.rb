
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
    bounding_box_with_space_before do
      use_font :size => 18
      text "Recommendations"
      default_font
      text "Based on your answers, the following was suggested:"
    end
    rule_sets.each do |rule_set|
      indented_bounding_box do
        use_font :size => 16
          text(
            rule_set.title
          )

        default_font
        text(
          strip_tags(rule_set.description)
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
    bounding_box_with_space_before do
      use_font :size => 16
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
    bounding_box_with_space_before(0) do
      use_font :style => :italic
      text "#{Time.now.to_s(:datetime)}", :align => :right
      move_down 20
      use_font :size => 22
      text "Warwickshire County Council: Online Self Support"
    end
    indented_bounding_box do
      default_font
      text "Below are the details of the data submitted to the Online Self Support system"
    end
  end
  
  def display_link_to_restore
    bounding_box_with_space_before do
      use_font :size => 22
      text "Return to questionnaire"
      default_font
      text "Use the link below to return to the self assessment site with these answers."
    end
    indented_bounding_box do
      url = "#{request.protocol}#{request.host}:#{request.port}/answer_stores/#{@answer_store.session_id}"
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
  
  def bounding_box_with_space_before(before = default_space_between_boxes)
    bounding_box([0, cursor - before], :width => bounds.width) { yield }
  end
  
  def indented_bounding_box
    width = bounds.width - (2 * default_indent)
    bounding_box([default_indent, cursor - default_space_between_boxes], :width => width) { yield }
  end
  
  def default_font
    use_font
  end
  
  def use_font(options = {})
    options[:size] ||= default_font_size
    font("Helvetica", options)
  end
  
end
