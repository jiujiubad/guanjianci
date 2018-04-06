require 'csv'

class GuanggaosController < ApplicationController
  before_action :find_guanggao, only: [:show, :edit, :update, :destroy]

  def index
    @q = Guanggao.ransack(params[:q])
    @guanggaos = @q.result.paginate(:page => params[:page], :per_page => 50)
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
  end

  def new
    @guanggao = Guanggao.new
  end

  def edit
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
    if @guanggao.update(guanggao_params)
      redirect_to guanggaos_path
    else
      render :edit
    end
  end

  def destroy
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

  def clean
    Guanggao.destroy_all
    redirect_to guanggaos_path
  end

  def import
    csv_string = params[:csv_file].read.force_encoding('utf-8')
    success = 0
    failed_records = []

    CSV.parse(csv_string) do |row|
      guanggao = Guanggao.new(
                               :huobi => row[0],
                               :guanjianzi => row[1])
      if guanggao.save
        success += 1
      else
        failed_records << [row, guanggao]
        Rails.logger.info("#{row} ----> #{guanggao.errors.full_messages}")
      end
    end

    flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
    redirect_to guanggaos_path
  end

  private

  def find_guanggao
    @guanggao = Guanggao.find(params[:id])
  end

  def guanggao_params
    params.require(:guanggao).permit(:huobi, :guanjianzi)
  end
end
