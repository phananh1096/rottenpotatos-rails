class Movie < ActiveRecord::Base
  attr_accessor :all_ratings, :ratings_to_show
  
  def self.with_ratings(ratings_list)
    #For part 1.2:Set ratings to show = ratings_list. But if is nil then needs to get all classes from Model?
    puts ratings_list
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    unless ratings_list.nil?
      return(Movie.where(rating: ratings_list)) #Do search
    # if ratings_list is nil, retrieve ALL movies    
    else
#       @ratings_to_show = []
      return(Movie.all)
    end
  end
  
  def self.all_ratings()
    #Get all ratings
    Movie.uniq.pluck(:rating)
  end
end
