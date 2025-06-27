class Owner::BookingsController < ApplicationController
  def index
    @upcoming_bookings = Booking.future
    @past_bookings = Booking.past
    @spaceships = current_user.spaceships
    @booking_requests = Booking.need_response
    @review = Review.new
    @bookings = current_user.bookings_as_owner
    @spaceship = Spaceship.new
  end
end
