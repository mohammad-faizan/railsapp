class InterviewsController < ApplicationController
  def index
    @list = Interview.includes(:candidate, :interview_rounds).all
    params[:type] = "interviews"
  end


  def new
    @interview = Interview.new
    @interview.interview_rounds.build
    load_people
  end

  def show
    @interview = Interview.includes(:interview_rounds, :candidate).find(params[:id])
  end

  def create
    @interview = Interview.new(interview_params)
    if @interview.save
      redirect_to interviews_url
    else
      render :new
    end
  end

  def edit
    @interview = Interview.find(params[:id])
    load_people
  end

  def update
    @interview = Interview.find(params[:id])
    load_people
  end

  def destroy
    @interview = Interview.find(params[:id])
    if @interview.destroy
      respond_to do |f|
        f.json {render json: {status: 'OK'}}
        f.js
      end
    end
  end

  private

  def interview_params
    params.require(:interview).permit(:candidate_id, :requirements, :interview_rounds_attributes => [:employee_id, :when, :where, :status])
  end

  def load_people
    @employees = Employee.includes(:skills).all
    @candidates = Candidate.includes(:skills).all
  end
end
