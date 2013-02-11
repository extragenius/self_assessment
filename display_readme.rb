require 'sinatra'
require 'rdoc/markup/to_html'

get '/' do
  input_string = ""
  parser = RDoc::Markup::ToHtml.new
  File.open("README.rdoc", "r") do |file|
    file.each_line{|l| input_string << l}
  end
  parser.convert(input_string)
  
end
