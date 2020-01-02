class OwnersController < ApplicationController
    
    get '/owners' do # WORKING
      @owners = Owner.all
      erb :'/owners/index' 
    end

    get '/owners/new' do # WORKING
      @pets = Pet.all
      erb :'/owners/new'
    end

    post '/owners' do # WORKING
      @owner = Owner.create(params[:owner])
      if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      redirect "/owners/#{@owner.id}"
    end

    get '/owners/:id' do |id| # WORKING
      @owner = Owner.find_by_id(id)
      erb :'/owners/show'
    end

    get '/owners/:id/edit' do |id|
      @pets = Pet.all
      @owner = Owner.find_by_id(id) #=> params[:id]
      # binding.pry
      erb :'/owners/edit'
    end
    
    patch '/owners/:id' do |id|
      if !params[:owner].keys.include?("pet_ids")
        params[:owner]["pet_ids"] = []
      end
      @owner = Owner.find_by_id(id)
      @owner.update(params[:owner])
      if !params[:pet][:name].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      # binding.pry
      redirect "owners/#{@owner.id}"
    end
  end
  
  
  
  