class Urls
attr_reader :url

  def initialize(url)
    @url = url
  end

  def self.git(url)
    system("cd desktop")
    system("git clone https://github.com/#{url}.git")
  end

end
