class ListingsController < ApplicationController
  def index
    render plain: (Listings.all.to_s)
    @listings = Listing.all
  end

  def show
    render(plain: "Listings " + params[:id] + " body " + Listings.get_by_id(params[:id]))
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
    redirect_to root_path
  end

  def update
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to(root_path)
  end

  private
  def lister_params
    params.require(:owner).permit(:title, :body, :picture)
end
