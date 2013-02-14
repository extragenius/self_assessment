
class Summary < Prawn::Document
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::UrlHelper
  
  attr_reader :answer_store
  
  def initialize(answer_store = nil)
    super()
    font("Helvetica", :size => default_font_size)

    if answer_store
      @answer_store = answer_store
      dispaly_header
      display_matching_rules
      display_answers
    else
      display_no_answers
    end
  end
      
  def display_no_answers
    text "You have not answered any questions"
  end
  
  def display_matching_rules
    bounding_box([0, cursor - 10], :width => bounds.width) do
      font_size default_font_size + 6
      text "Recommendations"
      font_size default_font_size
      text "Based on your answers, the following was suggested:"
    end
    rule_sets.each do |rule_set|
      bounding_box([0, cursor - 10], :width => bounds.width) do
        font_size default_font_size + 4
          text(
            rule_set.title
          )

        font_size default_font_size
        text(
          strip_tags(rule_set.description)
        ) if rule_set.description
        
        font_size default_font_size
        text(
          link_to(rule_set.link_text? ? rule_set.link_text : rule_set.url, rule_set.url),
          :color => "0000FF",
          :inline_format => true 
        ) if rule_set.url
      end
    end
  end
  
  def display_answers
    bounding_box([0, cursor - 10], :width => bounds.width) do
      text "Below are the answers you submitted"
      header = %w{Question Answer}
      data = answer_store.answers.collect{|a| [a.question.title, a.value]}
      data = [header] + data
      table data, :header => true
    end
  end
  
  def dispaly_header
    bounding_box([0, cursor - 10], :width => bounds.width) do
      font_size default_font_size + 10
      text "Warwickshire County Council: Online Self Support"

      font_size default_font_size
      text "Below are the details of the data submitted to the Online Self Support system at #{Time.now.to_s(:datetime)}"
    end
  end
  
  def rule_sets
    Qwester::RuleSet.matching(answer_store.answers)
  end
  
  def default_font_size
    12
  end
  
end
