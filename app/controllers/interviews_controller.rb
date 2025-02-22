class InterviewsController < ApplicationController
  def index
    params[:type] = "interviews"
    @list = Interview.page(params[:page]).includes(:candidate, interview_rounds: [:employee, {skill_ratings: :skill}])
  end


  def new
    @interview = Interview.new
    @interview.interview_rounds.build
    load_people
  end

  def show
    @interview = Interview.get_interviews(params[:id]).first
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
    if @interview.update(interview_params)
      redirect_to @interview
    else
      render :edit
    end
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

  def reports
    @list = Interview.filter_candidates_by_rating(params[:report])
  end

  private

  def interview_params
    params.require(:interview).permit(:candidate_id, :requirements, :interview_rounds_attributes => [:id, :employee_id, :when, :where, :status, :_destroy])
  end

  def load_people
    @employees = Employee.includes(:skills).all
    @candidates = Candidate.includes(:skills).all
  end
end
