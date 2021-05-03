require 'csv'
#require 'pry'

class Gossip
  attr_accessor :author, :content, :id

  def initialize(id="",author,content)
  @author = author
  @content = content
  @id=id
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = [] #on initialise un array vide
    id = 1
    CSV.read("./db/gossip.csv").each do |csv_line| # va chercher chacune des lignes du csv do
      all_gossips << Gossip.new(id,csv_line[0],csv_line[1])# crée un gossip avec les infos de la ligne + all_gossips << gossip qui vient d'être créé
      id +=1
    end
    return all_gossips #on retourne un array rempli d'objets Gossip
  end

  def self.find(id)
      return all[id.to_i-1]
  end

  def self.update(id,gossip_author_update,gossip_content_update)
    all_gossips = self.all
    all_gossips[id].content = gossip_content_update
    all_gossips[id].author = gossip_author_update
    File.open("./db/gossip.csv", "w") {|row| row.truncate(0)}
    all_gossips.each do |gossip|
       gossip.save
    end
  end  
end