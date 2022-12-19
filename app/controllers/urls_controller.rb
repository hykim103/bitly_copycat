class UrlsController < ApplicationController
  before_action :set_user
  before_action :set_url, except: :index

  def index
    @urls = Url.where(user: @user)
  end

  def show
    @url = Url.find(params[:id])
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    @url.title = @url.destination if @url.title.nil?
    @url.short_link = random_link if @url.short_link.nil?

    if @url.save!
      redirect_to urls_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @url.update(url_params)
    redirect_to url_path(@url)
  end

  def destroy
    @url.destroy
    redirect_to urls_path
  end

  private

  def url_params
    permit(:url).require(:destination, :title, :short_link)
  end

  def set_user
    @user = current_user
  end

  def set_url
    @url = Url.find(params[:id])
  end

  def random_link
    letters = ('A'..'z').to_a + (0..9).to_a
    random_link = letters.sample(9).join until Url.find_by(sort_link: random_link).nil?
  end
end
