require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'find with same director' do
    before :each do
      @fake_movies = [double('Star Wars'), double('THX-1138')]
    end
    it 'should find the movies with the same director using the movie model' do
      movie = double('movie with director')
      movie.stub(:id).and_return(1)
      movie.stub(:director).and_return('George Lucas')
      ret_movie = Movie.stub(:find).and_return(movie)
      expect(ret_movie).to receive(:find_with_same_director) {@fake_movies}
      post :find_with_same_director, {:id => '1'}
    end
  end

  describe 'find with same director' do
    before :each do
      @fake_movies = [double('Star Wars'), double('THX-1138')]
    end
     it 'should redirect to movie list when the movie has no director information' do
       movie = double('movie without director')
       movie.stub(:id).and_return(1)
       movie.stub(:director).and_return('')
       ret_movie = Movie.stub(:find).and_return(movie)
       expect(response).to redirect_to movies_path
     end
  end
end
