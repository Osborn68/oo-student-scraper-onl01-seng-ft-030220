require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    students = []
   
    doc.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a/@href").text
      hash = {:name => name, :location => location, :profile_url => profile_url}
     students << hash
   end
   return students
     
     #binding.pry
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    
    student = {}
    
    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    
    
    # scrape these into a hash, social media, quote, bio
    social = []
    doc.css("div.social-icon-container/a/@href").each do |sm|
      social << sm.value 
    end
    
    social.each do |m|
    if  m.include?("twitter")
      student[:twitter] = m 
      elsif m.include?("linkedin")
      student[:linkedin] = m
      elsif m.include?("github")
      student[:github] = m
      elsif m != nil 
      student[:blog] = m 
    end 
  end
    student
    #binding.pry
    
    
  end
end
