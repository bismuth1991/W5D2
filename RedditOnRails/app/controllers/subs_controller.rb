class SubsController < ApplicationController
  def new
    render :new
  end

  def index
    render :index
  end

  def create
    sub = Sub.new(sub_params)
    sub.moderator_id = current_user.id

    if sub.save
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def show
    @sub = Sub.find(params[:id])

    if @sub
      render :show
    else
      redirect_to subs_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    if @sub.moderator_id != current_user.id
      flash[:errors] = ["You're not authorized to modify this Sub!"]
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def update
    sub = Sub.find(params[:id])

    if sub.update(sub_params)
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      redirect_to edit_sub_url
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
