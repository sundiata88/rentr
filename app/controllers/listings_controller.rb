class ListingsController < ApplicationController
  def index
    # render plain: (Listings.all.to_s)
    @listings = Listing.all.reverse
  end

  def show
    #render(plain: "Listings " + params[:id] + " body " + Listings.get_by_id(params[:id]))
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    @listing.save
    redirect_to listing_path(@listing)
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    redirect_to listing_path(@listing)
  end

  def edit
    @listing = Listing.find(params[:id])
    if current_user != @listing.user
      redirect_to root_path
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    if current_user == @listing.user
    @listing.destroy
  end
    redirect_to(root_path)
  end

  end

  private
  def listing_params
    params.require(:listing).permit(:title, :body, :photo)
end
