require_relative '../test_helper'

class TranslationExtractorTest < ActiveSupport::TestCase
  
  def setup
    @title = 'Warning'
    @description = 'Some description'
    @message = 'One option'
    @link = 'Link text'
    
    @data = {
      en: {ominous: {warning: {some_warning: {
              title: @title ,
              description: @description,
              go_to_care_assessment_page: {
                message: @message,
                link: @link
              }
      }}}}
    }
    
    @output = [
      {locale: :en, key: 'ominous.warning.some_warning.title', value: @title},
      {locale: :en, key: 'ominous.warning.some_warning.description', value: @description},
      {locale: :en, key: 'ominous.warning.some_warning.go_to_care_assessment_page.message', value: @message},
      {locale: :en, key: 'ominous.warning.some_warning.go_to_care_assessment_page.link', value: @link},
    ]
  end
  
  def test_extractor
    assert_equal(@output, TranslationExtractor.to_language_attributes(@data))
  end
  
end
