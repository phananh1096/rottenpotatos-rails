class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #Checks if new landing to fetch session
    if params[:sort].nil? and params[:ratings].nil? and (!session[:sort].nil? or !session[:ratings].nil?)
      redirect_to(movies_path({:sort => session[:sort], :ratings => session[:ratings]} ))
#       params[:sort] = session[:sort]
#       params[:ratings] = session[:ratings]
    end
      
    #Main control loop
    unless params[:sort].nil?
      if params[:sort] == "Title"
        @titleCSS = "hilite bg-warning"
      else
        @releasedateCSS = "hilite bg-warning"
      end
      @all_ratings = Movie.all_ratings
      unless params[:ratings].nil?
        @movies = Movie.sort_ratings_by(params[:sort], params[:ratings].keys)
        @ratings_to_show = params[:ratings].keys
      else
        @movies = Movie.sort_ratings_by(nil, nil)
        @ratings_to_show = []
      end
    else
      @all_ratings = Movie.all_ratings
      unless params[:ratings].nil?
        @movies = Movie.with_ratings(params[:ratings].keys)
        @ratings_to_show = params[:ratings].keys
      else
        @movies = Movie.with_ratings(nil)
        @ratings_to_show = Movie.all_ratings
      end
    end

    #Store session variables
    session[:sort] = params[:sort]
    session[:ratings] = params[:ratings]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
