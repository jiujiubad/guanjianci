class CreateGuanggaos < ActiveRecord::Migration[5.1]
  def change
    create_table :guanggaos do |t|
      t.string :huobi
      t.string :guanjianzi

      t.timestamps
    end
  end
end
