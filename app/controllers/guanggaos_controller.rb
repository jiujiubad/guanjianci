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

  def gg_update
    ids = Array(params[:ids]) #当右边的ids为nil时，也能保证输出的是阵列
    guanggaos = ids.map{ |i| Guanggao.find_by_id(i) }.compact #compace是去除阵列里的nil
    if params[:commit] == "删除"
      guanggaos.each{ |e| e.destroy }
    end
    redirect_to guanggaos_path
  end

  private

  def guanggao_params
    params.require(:guanggao).permit(:huobi, :guanjianzi)
  end
end
