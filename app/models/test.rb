require 'selenium-webdriver'
require 'open-uri'
require 'nokogiri'

keyword = "ruby"

driver = Selenium::WebDriver.for(:chrome)
driver.navigate.to("http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{keyword}")

# 検索結果を開く
doc = Nokogiri::HTML(driver.page_source)

# liタグ以下を繰り返す
doc.search("div#search ol li").each_with_index do |li, idx|
href = ""
html = ""
link = ""

# aタグの中身を解析
li.search("h3 a").each do |alink|
href = alink.attribute("href")
URI.parse(href).query.split(/&/).each do |str|
strs = str.split(/=/)
link = strs[1] if strs[0] == "q"
end
html = alink.inner_html
end

# Webサイト以外（ニュースなど）はスキップ
next if "#{href}" !~ /^\/url/

# 結果表示
puts "idx: #{idx+1}"
puts "domain: #{link.split("/")[2]}"
puts "link: #{link}"
puts "html: #{html}"
puts ""

end