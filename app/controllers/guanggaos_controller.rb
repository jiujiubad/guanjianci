require 'csv'

class GuanggaosController < ApplicationController
  before_action :find_guanggao, only: [:show, :edit, :update, :destroy]

  def index
    @q = Guanggao.ransack(params[:q])
    @guanggaos = @q.result.paginate(:page => params[:page], :per_page => 50)
    respond_to do |format|
      format.html
      format.xlsx
      format.csv {
        @guanggaos = @guanggaos.reorder("id ASC")
        csv_string = CSV.generate do |csv|
          csv << [
            "日期",
            "货币",
            "广告活动名称",
            "广告组名称",
            "关键字",
            "匹配类型",
            "客户搜索词",
            "展现量",
            "点击量",
            "点击率(CTR)",
            "每次点击成本(CPC)",
            "花费",
            "7天总销售额($)",
            "广告成本销售比(ACoS)",
            "投入产出比(RoAS)",
            "7天总订单数",
            "7天总销售量",
            "7天转化率",
            "7天内广告sku销售量",
            "7天内其他sku销售量",
            "7天内广告sku销售额($)",
            "7天内其他sku销售额($)"
          ]
          @guanggaos.each do |g|
            csv << [
              g.riqi,
              g.huobi,
              g.guanggao_huodongmingcheng,
              g.guanggaozu_mingcheng,
              g.guanjianzi,
              g.pipeileixing,
              g.kehu_sousuoci,
              g.zhanxianliang,
              g.dianjiliang,
              g.dianjilv,
              g.meicidianji_chengben,
              g.huafei,
              g.qitian_zongxiaoshoue,
              g.guanggao_chengben_xiaoshoubi,
              g.touruchanchubi,
              g.qitian_zongdingdanshu,
              g.qitian_zongxiaoshouliang,
              g.qitian_zhuanhualv,
              g.qitiannei_guanggao_sku_xiaoshouliang,
              g.qitiannei_qita_sku_xiaoshouliang,
              g.qitiannei_guanggao_sku_xiaoshoue,
              g.qitiannei_qita_sku_xiaoshoue
            ]
          end
        end
        send_data csv_string, :filename => "广告-#{Time.now.to_s(:number)}.csv"
      }
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
        :riqi =>  Time.parse(row[0]),
        :huobi => row[1],
        :guanggao_huodongmingcheng => row[2],
        :guanggaozu_mingcheng => row[3],
        :guanjianzi => row[4],
        :pipeileixing => row[5],
        :kehu_sousuoci => row[6],
        :zhanxianliang => row[7],
        :dianjiliang => row[8],
        :dianjilv => row[9],
        :meicidianji_chengben => row[10],
        :huafei => row[11],
        :qitian_zongxiaoshoue => row[12],
        :guanggao_chengben_xiaoshoubi => row[13],
        :touruchanchubi => row[14],
        :qitian_zongdingdanshu => row[15],
        :qitian_zongxiaoshouliang => row[16],
        :qitian_zhuanhualv => row[17],
        :qitiannei_guanggao_sku_xiaoshouliang => row[18],
        :qitiannei_qita_sku_xiaoshouliang => row[19],
        :qitiannei_guanggao_sku_xiaoshoue => row[20],
        :qitiannei_qita_sku_xiaoshoue => row[21] )
      if guanggao.save
        success += 1
      else
        failed_records << [row, guanggao]
        Rails.logger.info("#{row} ----> #{guanggao.errors.full_messages}")
      end
    end
    failed_records.each do |record|
      flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
      flash[:alert] = "#{record[0]} ---> #{record[1].errors.full_messages}"
    end
    redirect_to guanggaos_path
  end

  private

  def find_guanggao
    @guanggao = Guanggao.find(params[:id])
  end

  def guanggao_params
    params.require(:guanggao).permit(:riqi, :huobi, :guanggao_huodongmingcheng, :guanggaozu_mingcheng, :guanjianzi, :pipeileixing, :kehu_sousuoci, :zhanxianliang, :dianjiliang, :dianjilv, :meicidianji_chengben, :huafei, :qitian_zongxiaoshoue, :guanggao_chengben_xiaoshoubi, :touruchanchubi, :qitian_zongdingdanshu, :qitian_zongxiaoshouliang, :qitian_zhuanhualv, :qitiannei_guanggao_sku_xiaoshouliang, :qitiannei_qita_sku_xiaoshouliang, :qitiannei_guanggao_sku_xiaoshoue, :qitiannei_qita_sku_xiaoshoue)
  end
end
