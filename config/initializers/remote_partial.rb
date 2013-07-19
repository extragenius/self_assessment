# Create WCC style partials from remote content 

protocol = Rails.env == 'production' ? 'https' : 'http'

remove_jquery_declaration = '{|html| html.gsub(/\<script.*src=\"https?\:[\/\-\.\w]+jquery\-[\.\w]+\.js.*\<\/script\>/, "")}'

RemotePartial.define(
  url: "#{protocol}://www.warwickshire.gov.uk/tpheadersa1",
  name: 'tpheadersa1',
  minimum_life: 6.hours,
  output_modifier: remove_jquery_declaration
)

RemotePartial.define(
  url: "#{protocol}://www.warwickshire.gov.uk/tpfootersa",
  name: 'tpfootersa',
  minimum_life: 6.hours,
)
