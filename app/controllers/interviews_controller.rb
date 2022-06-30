class InterviewsController < ApplicationController
  def index
    @list = Interview.includes(:candidate, :interview_rounds).all
    params[:type] = "interviews"
  end


  def new
    @interview = Interview.new
    @interview.interview_rounds.build# = [InterviewRound.new]
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

  private

  def interview_params
    params.require(:interview).permit(:candidate_id, :requirements, :interview_rounds_attributes => [:employee_id, :when, :where, :status])
  end

  def load_people
    @employees = Employee.includes(people_skills: [:skills]).all
    @candidates = Candidate.includes(people_skills: [:skills]).all
  end
end
