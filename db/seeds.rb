require 'pry'

require_relative '../models/merchant'
require_relative '../models/tag'
require_relative '../models/transaction'
require_relative '../models/utils'
require_relative '../models/budget'

merchants = [
  Merchant.new({'name' => 'Tesco'}),
  Merchant.new({'name' => 'Sainsburys'}),
  Merchant.new({'name' => 'Boots'}),
  Merchant.new({'name' => 'Marks and Spencers'}),
  Merchant.new({'name' => 'Gap'}),
  Merchant.new({'name' => 'Zara'}),
  Merchant.new({'name' => 'B & Q'}),
  Merchant.new({'name' => 'Scotmid'}),
  Merchant.new({'name' => 'Superdrug'}),
  Merchant.new({'name' => 'Peppers'}),
  Merchant.new({'name' => 'Preachers'}),
  Merchant.new({'name' => 'Chanter'}),
  Merchant.new({'name' => 'Bread Meets Bread'}),
  Merchant.new({'name' => 'Lloyds Pharmacy'}),
  Merchant.new({'name' => 'Annadale Nursery'}),
  Merchant.new({'name' => 'Filmhouse'})
]

tags = [
  Tag.new({'name' => 'Groceries'}),
  Tag.new({'name' => 'Toiletries'}),
  Tag.new({'name' => 'Clothing'}),
  Tag.new({'name' => 'Eating Out'}),
  Tag.new({'name' => 'DIY'}),
  Tag.new({'name' => 'Entertainment'}),
  Tag.new({'name' => 'Childcare'}),
  Tag.new({'name' => 'Drinks'}),
  Tag.new({'name' => 'Healthcare'})
]

tags.each{|tag| tag.save }
merchants.each{|merchant| merchant.save }

transactions = [
  Transaction.new({'amount' => 1000, 'dt' => '2018/03/01','merchant_id' => merchants[0].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 700, 'dt' => '2018/03/01', 'merchant_id' => merchants[9].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 685, 'dt' => '2018/03/01', 'merchant_id' => merchants[2].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 2270, 'dt' => '2018/03/01', 'merchant_id' => merchants[15].id, 'tag_id' => tags[5].id}),
  Transaction.new({'amount' => 4560, 'dt' => '2018/03/01', 'merchant_id' => merchants[3].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 1000, 'dt' => '2018/02/15','merchant_id' => merchants[0].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 700, 'dt' => '2018/01/15', 'merchant_id' => merchants[1].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 685, 'dt' => '2017/12/23', 'merchant_id' => merchants[2].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 4560, 'dt' => '2017/12/23', 'merchant_id' => merchants[3].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 1050, 'dt' => '2018/02/15', 'merchant_id' => merchants[4].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 1145, 'dt' => '2018/02/17', 'merchant_id' => merchants[5].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 245, 'dt' => '2018/01/10', 'merchant_id' => merchants[6].id, 'tag_id' => tags[4].id}),
  Transaction.new({'amount' => 985, 'dt' => '2018/01/02', 'merchant_id' => merchants[7].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 445, 'dt' => '2018/02/13', 'merchant_id' => merchants[8].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 775, 'dt' => '2018/02/02', 'merchant_id' => merchants[9].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 3420, 'dt' => '2018/02/02', 'merchant_id' => merchants[15].id, 'tag_id' => tags[5].id}),
  Transaction.new({'amount' => 2267, 'dt' => '2017/12/21', 'merchant_id' => merchants[10].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 1054, 'dt' => '2018/02/10', 'merchant_id' => merchants[11].id, 'tag_id' => tags[7].id}),
  Transaction.new({'amount' => 1235, 'dt' => '2018/01/01', 'merchant_id' => merchants[12].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 590, 'dt' => '2018/01/06', 'merchant_id' => merchants[13].id, 'tag_id' => tags[8].id}),
  Transaction.new({'amount' => 780, 'dt' => '2018/02/03', 'merchant_id' => merchants[14].id, 'tag_id' => tags[6].id}),
  Transaction.new({'amount' => 1378, 'dt' => '2018/02/01', 'merchant_id' => merchants[1].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 456, 'dt' => '2017/12/15', 'merchant_id' => merchants[2].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 550, 'dt' => '2017/11/22', 'merchant_id' => merchants[8].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 750, 'dt' => '2017/11/07', 'merchant_id' => merchants[6].id, 'tag_id' => tags[4].id})
]

transactions.each {|transaction| transaction.save}
transactions.each do |transaction|
  transaction.date = transaction.date << 1
  transaction.save
end

budgets = [
  Budget.new({'amount' => 50000}),
  Budget.new({'amount' => 15000, 'tag_id' => tags[0].id}),
  Budget.new({'amount' => 3000, 'tag_id' => tags[1].id}),
  Budget.new({'amount' => 7500, 'tag_id' => tags[3].id}),
  Budget.new({'amount' => 5000, 'tag_id' => tags[5].id})
]

budgets.each {|budget| budget.save}

binding.pry

nil
