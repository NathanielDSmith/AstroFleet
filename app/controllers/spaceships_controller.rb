class SpaceshipsController < ApplicationController
  before_action :set_spaceship, only: [:show, :edit, :update, :destroy]
  # What is this???
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:index, :show]

  # for the renters
  def index
    @spaceships = Spaceship.all

    if params[:query].present?
      @spaceships = @spaceships.where("name ILIKE ?", "%#{params[:query]}%")
    end

    if params[:budget].present? && params[:budget].to_i > 0
      @spaceships = @spaceships.where("price <= ?", params[:budget].to_i)
    end

    if params[:size].present?
      @spaceships = @spaceships.where(size: params[:size])
    end
  end

  def show
    @booking = Booking.new
    @reviews = Review.all
  end

  # for the spaceship owners
  def new
    @spaceship = Spaceship.new
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    @spaceship.user = current_user
    if @spaceship.save
      redirect_to owner_bookings_path, notice: "Spaceship successfully created!"
    else
      # If we're coming from the owner bookings page, redirect back there with errors
      if request.referer&.include?('owner/bookings')
        redirect_to owner_bookings_path, alert: "Failed to create spaceship: #{@spaceship.errors.full_messages.join(', ')}"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end


  def edit
    redirect_to root_path unless @spaceship.user == current_user
  end

  def update
    if @spaceship.user == current_user && @spaceship.update(spaceship_params)
      redirect_to @spaceship
    else
      render :edit
    end
  end

  def destroy
    if @spaceship.user == current_user
      @spaceship.destroy
      redirect_to spaceships_path
    else
      redirect_to root_path
    end
  end

  private

  def set_spaceship
    @spaceship = Spaceship.find(params[:id])
  end

  def spaceship_params
    params.require(:spaceship).permit(:name, :price, :max_speed, :features, :size, :photo, :description)
  end

  def authenticate_owner!
    redirect_to root_path unless current_user&.owner?
  end
end
