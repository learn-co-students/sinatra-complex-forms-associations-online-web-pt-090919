class PetsController < ApplicationController

    get '/pets' do # WORKING
      @pets = Pet.all
      erb :'/pets/index' 
    end

    get '/pets/new' do # WORKING
      @owners = Owner.all
      erb :'/pets/new'
    end

    post '/pets' do # WORKING
      @pet = Pet.create(params[:pet]) # create a new pet
      if !params[:owner][:name].empty?
        @pet.owner = Owner.create(name: params[:owner][:name])
      else
        @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
      end
      @pet.save
      redirect "/pets/#{@pet.id}"
    end

    get '/pets/:id' do |id| # WORKING
      @pet = Owner.find_by_id(id)
      erb :'/pets/show'
    end

    get '/pets/:id/edit' do |id|
      @pets = Pet.all
      @pet = Pet.find_by_id(id) #=> params[:id]
      # binding.pry
      erb :'/pets/edit'
    end

    patch '/pets/:id' do |id|
      if !params[:pet].keys.include?("owner_id")
        params[:pet][:owner_id] = []
      end
      @pet = Pet.find_by_id(id)
      @pet.update(params[:pet])
      if !params[:owner][:name].empty?
        @pet.owner = Owner.create(name: params[:owner][:name])
      else
        @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
      end
      @pet.save
      redirect "pets/#{@pet.id}"
    end
  end
  
  
  
  
  
  