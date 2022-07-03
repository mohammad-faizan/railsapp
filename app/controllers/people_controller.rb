class PeopleController < ApplicationController
  def index
  end

  def list
    table = Module.const_get(params[:type].capitalize)
    if valid_type(table.new)
      @list = table.page(params[:page]).includes(:skills)
      params[:type] = table.to_s.downcase
      render :people_list
    else
      redirect_to root_url
    end
  end

  def show
    # Dangerous to use Module.const_get
    # Just to show how to get constant dynamically
    @person = Module.const_get(params[:type].capitalize).includes(:skills).find(params[:id])
  end

  def new
    @person = Module.const_get(params[:type].capitalize).new
  end

  def edit
    @person = Module.const_get(params[:type].capitalize).find(params[:id])
  end

  def create
    @person = Module.const_get(person_params[:type]).new(person_params)
    if valid_type(@person)
      if @person.save
        redirect_to list_url(type: @person.type.downcase)
      else
        render :new
      end
    else
      redirect_to root_url
    end
  end

  def update
    @person = Module.const_get(person_params[:type]).find(params[:id])
    if @person.update(person_params)
      redirect_to person_path(@person, type: @person.class)
    else
      render :edit
    end
  end

  def destroy
    @person = Module.const_get(params[:type]).find(params[:id])
    if @person.destroy
      respond_to do |f|
        f.json {render json: {status: 'OK'}}
        f.js
      end
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :email, :dob, :experience, :type)
  end

  def valid_type(type)
    (type.is_a?(Employee) or type.is_a?(Candidate))
  end
end
