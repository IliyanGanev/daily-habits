class TextAnswersController < ApplicationController

  def show
    @user = current_user
    @question = Question.find(params[:question_id])
    @text_answer = TextAnswer.find(params[:id])
  end

  def new
    @text_answer = TextAnswer.new
  end

  def create
    @user = current_user
    @question = Question.find(params[:question_id])
    @text_answer = TextAnswer.new(text_answer_params)
    @text_answer.question_id = @question.id
    @text_answer.ip_address = request.remote_ip
    if @text_answer.save
      redirect_to user_questions_path(@user)
    else
      @errors = @text_answer.errors.full_messages
      redirect_to user_questions_path(@user)
    end 
  end

  # time to response

  private
    def text_answer_params
      params.require(:text_answer).permit(:response, :question_id, :avatar)
    end

    def random_num
      rand(1..9)
    end

    def fake_ip
      "136.0.16.21#{random_num}"
    end
end
