class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash.now[:success] = "#{@person.name} has been added"
      render :action => 'show', :id => @person.id
    else
      flash.now[:error] = "We were unable to add the person due to missing or incorrect information"
      render 'new'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @name = @person.name
    @person.destroy
    flash[:success] = "#{:name} successfully deleted"
    redirect_to people_path
  end

  def show
    @person = Person.find_by_id(params[:id])
    if @person.nil?
      flash.now[:error] = "The person you are looking for does not exist or the id was invalid"
      render "index"
    else
      @person
    end
  end

  def edit
    @person = Person.find_by_id(params[:id])
    if @person.nil?
      flash.now[:error] = "The person you are looking for does not exist or the id was invalid"
      render 'index'
    else
      render 'edit'
    end
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:success] = "Person updated"
      redirect_to person_path(@person)
    else
      flash[:error] = "Update unsuccessful"
      redirect_to edit_person_path(@person)
    end
  end
  end

