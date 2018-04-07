class AddMoreDetailToGuanggaos < ActiveRecord::Migration[5.1]
  def change
    add_column :guanggaos, :riqi, :string
    add_column :guanggaos, :guanggao_huodongmingcheng, :string
    add_column :guanggaos, :guanggaozu_mingcheng, :string
    add_column :guanggaos, :pipeileixing, :string
    add_column :guanggaos, :kehu_sousuoci, :string
    add_column :guanggaos, :zhanxianliang, :integer
    add_column :guanggaos, :dianjiliang, :integer
    add_column :guanggaos, :dianjilv, :float
    add_column :guanggaos, :meicidianji_chengben, :float
    add_column :guanggaos, :huafei, :float
    add_column :guanggaos, :qitian_zongxiaoshoue, :float
    add_column :guanggaos, :guanggao_chengben_xiaoshoubi, :float
    add_column :guanggaos, :touruchanchubi, :float
    add_column :guanggaos, :qitian_zongdingdanshu, :integer
    add_column :guanggaos, :qitian_zongxiaoshouliang, :integer
    add_column :guanggaos, :qitian_zhuanhualv, :float
    add_column :guanggaos, :qitiannei_guanggao_sku_xiaoshouliang, :integer
    add_column :guanggaos, :qitiannei_qita_sku_xiaoshouliang, :integer
    add_column :guanggaos, :qitiannei_guanggao_sku_xiaoshoue, :float
    add_column :guanggaos, :qitiannei_qita_sku_xiaoshoue, :float
  end
end
