require 'spec_helper'
require 'rails_helper'

describe MoviesController do
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
    end
  end
end
