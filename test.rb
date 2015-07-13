require 'open-uri'
require 'Nokogiri'


@doc = Nokogiri::HTML(open("https://github.com/APKirstein?tab=repositories"))
@urls = @doc.xpath("//h3")

@urls.each do |url|
  puts url.children[1].attribute("href").children
end
