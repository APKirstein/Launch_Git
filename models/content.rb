require 'open-uri'
require 'Nokogiri'
require 'pg'
require 'pry'

require_relative 'urls'

class Content
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.db_connection
    begin
      connection = PG.connect(dbname: "launch_git")
      yield(connection)
    ensure
      connection.close
    end
  end

  def self.all
    list = db_connection do |conn|
      conn.exec("SELECT * FROM users")
    end
    user_list = []
    list.each do |usr|
      user_list << Content.new(usr["id"], usr["name"])
    end
    user_list
  end

  def self.find(usr)
    finder = db_connection do |conn|
      conn.exec_params("SELECT id, name FROM users
      WHERE name = ($1)", [usr])
    end
    Content.new(finder.first["id"], finder.first["name"])
  end

  def self.urls(usr)
    list = []
    @doc = Nokogiri::HTML(open("https://github.com/#{usr}?tab=repositories"))
    @urls = @doc.xpath("//h3")
    @urls.each do |url|
      list << Urls.new(url.children[1].attribute("href").children)
    end
    list
  end

end


# https://github.com/APKirstein?tab=repositories
