class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    flash[:notice] = "ジャンル登録に成功しました"
      redirect_to request.referer
    else
      @genres = Genre.all
      redirect_to request.referer
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = '変更を保存しました'
      redirect_to admin_genre_path(@genre.id)
    else
      render :edit
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
