require 'rails_helper'

describe MoviesController do

    describe "#director" do
        context "When specified movie has a director" do
            
            it "should find movies with the same director" do
            
            @movie_id="1234"
            @movie=double('fake_movie', :director => 'Bill Condon')
            
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:similar_movies)
            
            get :director, :id => @movie_id
            
            expect(response).to render_template(:director)
        end
    end
        context "When specified movie has no director" do
            it "should redirect to the movies page" do
            @movie_id="1234"
            @movie=double('fake_movie').as_null_object
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :director, :id => @movie_id
            expect(response).to redirect_to(movies_path)
            
            end
        end
    end

  describe "#create" do
    it "should create movie with provided parameters" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        @defaults = { :title => "Terrible Movie", :rating => "G", :director => "Dr. V" }
        expect(Movie).to receive(:create!).and_return(@movie)
        post :create, :movie => @defaults
        expect(response).to redirect_to(movies_path)
    end
  end
  describe "#show" do
    it "should display details about an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :show, :id => @movie_id
        expect(response).to render_template(:show)
    end
  end
  describe "#destroy" do
    it "should delete the specific movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
        expect(@movie).to receive(:destroy)
        delete :destroy, :id => @movie_id
        expect(response).to redirect_to(movies_path)
    end
  end
  describe "#edit" do
    it "should edit an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :edit, :id => @movie_id
        expect(response).to render_template(:edit)
    end
  end
  describe "#new" do
    it "should render the new template" do
        # the new method doesn't actualy do anything besides render new.html.haml
        get :new 
        expect(response).to render_template(:new)
    end
  end
end
