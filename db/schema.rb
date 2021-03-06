# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180406215226) do

  create_table "guanggaos", force: :cascade do |t|
    t.string "huobi"
    t.string "guanjianzi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "riqi"
    t.string "guanggao_huodongmingcheng"
    t.string "guanggaozu_mingcheng"
    t.string "pipeileixing"
    t.string "kehu_sousuoci"
    t.integer "zhanxianliang"
    t.integer "dianjiliang"
    t.float "dianjilv"
    t.float "meicidianji_chengben"
    t.float "huafei"
    t.float "qitian_zongxiaoshoue"
    t.float "guanggao_chengben_xiaoshoubi"
    t.float "touruchanchubi"
    t.integer "qitian_zongdingdanshu"
    t.integer "qitian_zongxiaoshouliang"
    t.float "qitian_zhuanhualv"
    t.integer "qitiannei_guanggao_sku_xiaoshouliang"
    t.integer "qitiannei_qita_sku_xiaoshouliang"
    t.float "qitiannei_guanggao_sku_xiaoshoue"
    t.float "qitiannei_qita_sku_xiaoshoue"
  end

end
