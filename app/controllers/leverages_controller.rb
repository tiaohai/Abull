class LeveragesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  def show
    @leverage   = Leverage.find(params[:id])
    @user       = @leverage.user
    @comments   = @leverage.comments
    @interests  = Interest.where(show: "true")
  end

  def new
    @leverage = current_user.leverages.build
    @interests  = Interest.where(show: "true")
    @leverage.user_id = current_user.id
  end

  def create
    @leverage = current_user.leverages.build(leverage_params)
    if @leverage.save
      redirect_to @leverage
    else
      render :new
    end
  end

  def edit
    @leverage = current_user.leverages.find(params[:id])
    @interests  = Interest.where(show: "true")
  end

  def update
    @leverage = current_user.leverages.find(params[:id])
    if @leverage.update(leverage_params)
      redirect_to @leverage
    else
      render 'edit'
    end
  end

  def query_rate
    amount = params[:amount].blank? ? 2000 : params[:amount]
    leverage_time = params[:leverage_time].blank? ? 5 : params[:leverage_time]
    duration = params[:duration].blank? ? 1 : params[:duration]

    rate = Interest.query(amount, leverage_time, duration)
    render json: {rate: rate}
  end

  private
    def leverage_params
      params.require(:leverage).permit(:user_id, :date, :amount, :description, :duration, :state, :interest_id)
    end
end
