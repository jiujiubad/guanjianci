require 'csv'
namespace :dev do
   task :import => :environment do
     success = 0
     failed_records = []
     CSV.foreach("#{Rails.root}/tmp/guanggao.csv") do |row|
       g = Guanggao.new(
                        :huobi => row[0],
                        :guanjianzi => row[1])
       if g.save
         success += 1
       else
         failed_records << [row, g]
       end
     end

     puts "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
     failed_records.each do |record|
       puts "#{record[0]} ---> #{record[1].errors.full_messages}"
     end
   end
end
