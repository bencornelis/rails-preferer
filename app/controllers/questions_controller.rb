class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :update]

  def index
    sleep 1
    @questions = Question.order(sort_options).paginate(page: params[:page], per_page: 5)
    flash[:notice] = ''
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @question = Question.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @question = Question.create(question_params)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    respond_to do |format|
      format.js
    end
  end

private

  def question_params
    params.require(:question).permit :option_a, :option_b, :option_a_count, :option_b_count, :image_a, :image_b
  end

  def sort_options
    if params[:sort]
      params[:sort]
    else
      "id desc"
    end
  end

end
