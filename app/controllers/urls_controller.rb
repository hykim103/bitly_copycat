class UrlsController < ApplicationController
  before_action :set_user
  before_action :set_urls, only: :show
  before_action :set_url, only: %i[edit update destroy]

  def index
    @urls = Url.where(user: @user)
    @url = Url.new
  end

  def show
  end

  def create
    @url = Url.new(url_params)

    @url.user = @user
    @url.title = @url.destination if @url.title.empty?
    @url.short_link = random_link if @url.short_link.empty?
    @url.final_url = "bitly.copycat/#{@url.short_link}"

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
    redirect_to urls_path
  end

  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def url_params
    params.require(:url).permit(:destination, :title, :short_link)
  end

  def set_urls
    @urls = Url.where(user: @user)
  end

  def set_user
    @user = current_user
  end

  def set_url
    @url = Url.find(params[:id])
  end

  def random_link
    letters = ('A'..'z').to_a + (0..9).to_a
    random_letters = letters.sample(9).join
    random_letters = letters.sample(9).join unless Url.find_by(short_link: random_letters).nil?
    random_letters
  end
end
