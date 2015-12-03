require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'list movies' do
    context 'order by title' do
      it 'should list the movies ordered by title' do
        movies = [double('Amelie'),double('Starwars')]
        sort = 'title'
        ordering = {title: :asc}
        selected_ratings = {rating: ["G", "NC-17", "PG", "PG-13", "R"]}
        #expect(Movie).to receive(:where).with(selected_ratings).and_return(movies)
        #expect(Movie).to receive(:order).with(ordering).and_return(movies)
      end
    end
    
    context 'order by release date' do
      it 'should list the movies ordered by release date' do
      end
    end
  end
  describe 'create movie' do
    it 'creates a movie and redirect to movies page' do
      movie_params = {title: 'Pi', rating: 'PG-13', release_date: '1999-06-02' }
      movie = double('Pi')
      movie.stub(:title).and_return(movie_params[:title])
      expect(Movie).to receive(:create!).with(movie_params).and_return(movie)
      post :create, {movie: movie_params}
      expect(flash[:notice]).to eq "#{movie.title} was successfully created."
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'update movie' do
    it 'updates a movie and redirect to the movie page' do
      id = "1"
      movie_params = {title: 'Pi', rating: 'PG-13', release_date: '1999-06-02' }
      movie = double('Pi')
      movie.stub(:title).and_return(movie_params[:title])
      expect(Movie).to receive(:find).with(id) { movie }
      expect(movie).to receive(:update_attributes!).with(movie_params).and_return(movie)
      patch :update, id: id, movie: movie_params
      expect(flash[:notice]).to eq "#{movie.title} was successfully updated."
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe 'destroy movie' do
    it 'destroys a movie and redirects to the movies page' do
      id = '1'
      movie = double('Pi')
      movie.stub(:title).and_return('Pi')
      expect(Movie).to receive(:find).with(id) {movie}
      expect(movie).to receive(:destroy).and_return(movie)
      delete :destroy, id: id
      expect(flash[:notice]).to eq "Movie '#{movie.title}' deleted."
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'find with same director' do
    before :each do
      @fake_movies = [double('Star Wars'), double('THX-1138')]
    end

    context 'the movie has a director' do
      it 'should find the movies with the same director using the movie model' do
        movie = double('movie with director')
        movie.stub(:id).and_return('1')
        movie.stub(:director).and_return('George Lucas')
        expect(Movie).to receive(:find).with(movie.id) { movie }
        allow(movie).to receive(:find_movies_with_same_director) { @fake_movies }
        get :find_with_same_director, {:id => movie.id}
      end

      it 'should select the movies with same director template for rendering' do
        movie = double('movie with director')
        movie.stub(:id).and_return('1')
        movie.stub(:director).and_return('George Lucas')
        movie.stub(:find_movies_with_same_director).and_return(@fake_movies)
        Movie.stub(:find).and_return(movie)
        get :find_with_same_director, {:id => movie.id}
        response.should render_template('find_with_same_director')
      end
     
      it 'should make the results available for that template' do
        movie = double('movie with director')
        movie.stub(:id).and_return('1')
        movie.stub(:director).and_return('George Lucas')
        movie.stub(:find_movies_with_same_director).and_return(@fake_movies)
        Movie.stub(:find).and_return(movie)
        get :find_with_same_director, {:id => movie.id}
        expect(assigns(:movies)).to eq @fake_movies
      end
    end

    context 'the movie does not have director information' do
      it 'should redirect to movies when there is no director information' do
        movie = double('movie without director')
        movie.stub(:id).and_return('2')
        movie.stub(:title).and_return('Movie without director')
        movie.stub(:director).and_return('')
        expect(Movie).to receive(:find).with(movie.id) { movie }
        allow(movie).to receive(:find_movies_with_same_director) { [] }
        get :find_with_same_director, {:id => movie.id}
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end
