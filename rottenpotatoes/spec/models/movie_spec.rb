require 'spec_helper'
require 'rails_helper'

describe Movie do
  context 'the movie has a director' do
    it 'should find movies with same director' do
      starwars = Movie.new
      starwars.director = 'George Lucas'
      starwars.title = 'Starwars'
      starwars.save!

      thx = Movie.new
      thx.director = 'George Lucas'
      thx.title = 'THX-1138'
      thx.save!

      movies_found = [starwars, thx]

      movie = Movie.new
      movie.director = 'George Lucas'
      movie.find_movies_with_same_director.should == movies_found
    end
  end
  context 'the movie does not have director information' do
    it 'should not find movies with different directors' do
      blade = Movie.new
      blade.title = 'Blade Runner'
      blade.director = 'Ridley Scott'

      movies_found = [blade]

      movie = Movie.new
      movie.director = 'George Lucas'
      movie.find_movies_with_same_director.should_not == movies_found

    end
  end
end
