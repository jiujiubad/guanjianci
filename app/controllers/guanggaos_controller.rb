class GuanggaosController < ApplicationController

  def index
    @guanggaos = Guanggao.all.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @guanggao = Guanggao.find(params[:id])
  end

  def new
    @guanggao = Guanggao.new
  end

  def edit
    @guanggao = Guanggao.find(params[:id])
  end

  def create
    @guanggao = Guanggao.new(guanggao_params)
    if @guanggao.save
      redirect_to guanggaos_path
    else
      render :new
    end
  end

  def update
    @guanggao = Guanggao.find(params[:id])
    if @guanggao.update(guanggao_params)
      redirect_to guanggaos_path
    else
      render :edit
    end
  end

  def destroy
    @guanggao = Guanggao.find(params[:id])
    @guanggao.destroy
    redirect_to guanggaos_path
  end

  def clean
    Guanggao.destroy_all
    redirect_to guanggaos_path
  end

  private

  def guanggao_params
    params.require(:guanggao).permit(:huobi, :guanjianzi)
  end
end
