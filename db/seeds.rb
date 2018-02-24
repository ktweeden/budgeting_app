require 'pry'

require_relative '../models/merchant'
require_relative '../models/tag'
require_relative '../models/transaction'


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
  Transaction.new({'amount' => 1000, 'merchant_id' => merchants[0].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 700, 'merchant_id' => merchants[1].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 685, 'merchant_id' => merchants[2].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 2270, 'merchant_id' => merchants[15].id, 'tag_id' => tags[5].id}),
  Transaction.new({'amount' => 4560, 'merchant_id' => merchants[3].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 1050, 'merchant_id' => merchants[4].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 1145, 'merchant_id' => merchants[5].id, 'tag_id' => tags[2].id}),
  Transaction.new({'amount' => 245, 'merchant_id' => merchants[6].id, 'tag_id' => tags[4].id}),
  Transaction.new({'amount' => 985, 'merchant_id' => merchants[7].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 445, 'merchant_id' => merchants[8].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 775, 'merchant_id' => merchants[9].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 3420, 'merchant_id' => merchants[15].id, 'tag_id' => tags[5].id}),
  Transaction.new({'amount' => 2267, 'merchant_id' => merchants[10].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 1054, 'merchant_id' => merchants[11].id, 'tag_id' => tags[7].id}),
  Transaction.new({'amount' => 1235, 'merchant_id' => merchants[12].id, 'tag_id' => tags[3].id}),
  Transaction.new({'amount' => 590, 'merchant_id' => merchants[13].id, 'tag_id' => tags[8].id}),
  Transaction.new({'amount' => 780, 'merchant_id' => merchants[14].id, 'tag_id' => tags[6].id}),
  Transaction.new({'amount' => 1378, 'merchant_id' => merchants[1].id, 'tag_id' => tags[0].id}),
  Transaction.new({'amount' => 456, 'merchant_id' => merchants[2].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 550, 'merchant_id' => merchants[8].id, 'tag_id' => tags[1].id}),
  Transaction.new({'amount' => 750, 'merchant_id' => merchants[6].id, 'tag_id' => tags[4].id})
]

transactions.each {|transaction| transaction.save}

binding.pry

nil
