class PersonController < ApplicationController
  def index
  end

  def list
    table = Module.const_get(params[:type].capitalize)
    if valid_type(table.new)
      @list = table.includes(:skills).all
      params[:type] = table.to_s.downcase
      render :person_list
    else
      redirect_to root_url
    end
  end

  def new
    @person = Module.const_get(params[:type].capitalize).new
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

  private

  def person_params
    params.require(:person).permit(:name, :email, :dob, :experience, :type)
  end

  def valid_type(type)
    (type.is_a?(Employee) or type.is_a?(Candidate))
  end
end
