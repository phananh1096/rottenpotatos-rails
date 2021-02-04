class Movie < ActiveRecord::Base
  attr_accessor :all_ratings, :ratings_to_show
  
  def self.with_ratings(ratings_list)
    #For part 1.2:Set ratings to show = ratings_list. But if is nil then needs to get all classes from Model?
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
  
  def self.sort_ratings_by(sort_field, ratings_list)
    unless ratings_list.nil?
      if sort_field == "Title"
        return(Movie.where(rating: ratings_list).order(:title)) #Do search
      else
        return(Movie.where(rating: ratings_list).order(:release_date)) #Do search
      end
    # if ratings_list is nil, retrieve ALL movies    
    else
#       @ratings_to_show = []
      if sort_field == "Title"
        return(Movie.all.order(:title))
      else
        return(Movie.all.order(:release_date))
      end
    end
  end
  
  def self.all_ratings()
    #Get all ratings
    Movie.uniq.pluck(:rating)
  end
end
