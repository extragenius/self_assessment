# Create WCC style partials from remote content 

remove_jquery_declaration = '{|content| content.gsub(/\<script.*src=\"https?\:[\/\-\.\w]+jquery\-[\.\w]+\.js.*\<\/script\>/, "")}'
minimum_life = 6.hours

RemotePartial.define(
  url: 'http://www.warwickshire.gov.uk/tpheadersa1',
  name: 'http_header',
  output_modifier: remove_jquery_declaration,
  minimum_life: minimum_life
)

RemotePartial.define(
  url: 'https://www.warwickshire.gov.uk/tpheadersa1',
  name: 'https_header',
  output_modifier: remove_jquery_declaration,
  minimum_life: minimum_life
)

RemotePartial.define(
  url: 'http://www.warwickshire.gov.uk/tpfootersa',
  name: 'footer',
  minimum_life: minimum_life
)

class WccStyling

  class << self

    def style_class
      "style-1"
    end

    def header_for(request)
      file = request.env["REQUEST_URI"] =~ /^https/ ? 'https_header' : 'http_header'
      path_for file
    end

    def footer
      path_for 'footer'
    end

    def path_for(file)
      "remote_partials/#{file}"
    end

  end

end