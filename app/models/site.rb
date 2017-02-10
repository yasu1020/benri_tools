class Site < ApplicationRecord

  require 'open-uri'
  require 'nokogiri'

  def self.html_push(url)

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを生成
    return Nokogiri::HTML.parse(html, nil, charset)

  end


  def self.test(url)

    doc = html_push(url)

    # タイトルを表示
    results = doc.css('h2,h3,h4,h5')

    results_new = []

    results.each do |ele|

      case ele.name
        when "h2" then
          ele.name = "<tr><td>" + ele.children.text.gsub(/(\r\n|\r|\n|\t)/, "") + "</td><td></td><td></td><td></td></tr>"
        when "h3" then
          ele.name = "<tr><td></td><td>" + ele.children.text.gsub(/(\r\n|\r|\n|\t)/, "") + "</td><td></td><td></td></tr>"
        when "h4" then
          ele.name = "<tr><td></td><td></td><td>" + ele.children.text.gsub(/(\r\n|\r|\n|\t)/, "") + "</td><td></td></tr>"
        when "h5" then
          ele.name = "<tr><td></td><td></td><td></td><td>" + ele.children.text.gsub(/(\r\n|\r|\n|\t)/, "") + "</td></tr>"
        else
      end
      results_new.push(ele.name)
    end

    #binding.pry

    return results_new

  end

  def self.title(url)

    doc = html_push(url)

    results = doc.css('title')

    return results.children.text

  end

end
