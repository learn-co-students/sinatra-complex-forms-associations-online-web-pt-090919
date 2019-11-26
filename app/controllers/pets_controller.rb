class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do  
    if params[:owner][:name].empty?
      @owner = Owner.find(params[:owner][:id])
    else 
      @owner = Owner.create(params[:owner])
    end 
    @pet = Pet.create(name: params[:pet][:name])
    @owner.pets << @pet  
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all 

    erb :'/pets/edit'
  end 

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if params[:owner][:name].empty?
      @owner = Owner.find(params[:owner][:id])
    else 
      @owner = Owner.create(name: params[:owner][:name])
    end 

    @pet.update(params[:pet])
    @owner.pets << @pet 
    
    redirect to "pets/#{@pet.id}"
  end
end