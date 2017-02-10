class Google < ApplicationRecord

  require 'open-uri'
  require 'nokogiri'
  require 'selenium-webdriver'

  def self.html_push(url)

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを生成
    return Nokogiri::HTML.parse(html, nil, charset)

  end


  def self.google_result(keyword)

    driver = Selenium::WebDriver.for(:chrome)
    driver.navigate.to("http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{keyword}")

    # 検索結果を開く
    doc = Nokogiri::HTML(driver.page_source)
    results = doc.css('h3.r > a')
    results_new = []

    results.each do |ele|
      results_new.push(ele.attribute('href').content)
    end

    return results_new

  end


end
