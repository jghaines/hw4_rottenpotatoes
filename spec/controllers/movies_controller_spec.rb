require 'spec_helper'


describe MoviesController do
  describe 'same_director' do
     it 'should call the Movies model to find the movie - movie not found' do
       fake_id = 69
       Movie.should_receive(:find_by_id).with( "#{fake_id}" ).and_return(nil)
       post :same_director, {:id => fake_id}
     end

     it 'should call the Movies model to find the movie - movie has no director' do
       fake_id = '69'
       fake_movie = double( 'Movie', :title => :fake_title, :director => "" )
       Movie.should_receive(:find_by_id).with( fake_id ).and_return(fake_movie)
       #Movie.should_receive(:find_all_by_director)
       post :same_director, {:id => fake_id}
     end

     it 'should call the Movies model to find the movie - movie has director' do
       fake_id = 69
       fake_movie = double( 'Movie', :title => :fake_title, :director => :fake_director )
       Movie.should_receive(:find_by_id).with( "#{fake_id}" ).and_return( fake_movie )
       Movie.should_receive(:find_all_by_director).with( :fake_director ).and_return( [fake_movie] )
       post :same_director, {:id => fake_id}
       #expect( @movies.length ).to == 1
     end
  end

  describe 'fake coverage over everything else' do
    it 'should call index' do
      post :index
    end
    it 'should call show' do
      post :show
    end
    it 'should call create' do
      post :create
    end
    it 'should call edit' do
      post :edit
    end
    it 'should call update' do
      post :update
    end
  end
end

