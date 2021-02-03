class Movie < ActiveRecord::Base
  attr_accessor :all_ratings, :ratings_to_show
  
  def self.with_ratings(ratings_list)
    #For part 1.2:Set ratings to show = ratings_list. But if is nil then needs to get all classes from Model?
    puts ratings_list
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    unless ratings_list.nil?
      @all_ratings = Movie.where(rating: ratings_list) #Do search
      @ratings_to_show = ratings_list
    # if ratings_list is nil, retrieve ALL movies    
    else
      @all_ratings = Movie.all
      @ratings_to_show = []
    end
  end

end
