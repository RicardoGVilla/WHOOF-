class BookingsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_dog, only: %i[show]

  def index
    # moses was here
    @bookings = current_user.bookings
    @bookings = Booking.all
  end

  def show
    @booking = set_booking
    # @booking.current_user = @dog
  end

  def new
    @booking = Booking.new
    @dog = Dog.find(params[:dog_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @dog = set_dog
    @booking.dog = @dog
    @booking.user = current_user
    if @booking.save
      redirect_to mybookings_path, notice: 'booking was successfully created'
    else
      redirect_to dog_bookings_path
    end
  end

  def edit
    @booking = Booking.find(set_booking)
  end

  def update
    @booking = Booking.find(set_booking)
    @booking.update(params[booking_params])
    redirect_to my_booking_path(@booking)
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:startdate, :enddate)
  end
end
