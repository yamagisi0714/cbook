# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{:category_name => '和食'},{:category_name => '洋食'},{:category_name => '中華'},{:category_name => '主食'},{:category_name => '主菜'},{:category_name => '副菜'},{:category_name => '汁物'},{:category_name => 'ソース'},{:category_name => 'ドレッシング'},{:category_name => 'パスタ'},{:category_name => 'サラダ'},{:category_name => 'パン'},{:category_name => '麺類'},{:category_name => '丼'},{:category_name => 'おつまみ'},{:category_name => 'お菓子'}])

User.create(name: '平八', account: 'aaa', email: 'a@a', password: 'aaaaaa')
User.create(name: '一八', account: 'sss', email: 's@s', password: 'ssssss')
User.create(name: '仁', account: 'ddd', email: 'd@d', password: 'dddddd')
User.create(name: 'ブルース', account: 'fff', email: 'f@f', password: 'ffffff')
User.create(name: 'キング', account: 'ggg', email: 'g@g', password: 'gggggg')
User.create(name: 'ジャック', account: 'hhh', email: 'h@h', password: 'hhhhhh')
User.create(name: 'ポール', account: 'jjj', email: 'j@j', password: 'jjjjjj')
User.create(name: 'ロウ', account: 'kkk', email: 'k@k', password: 'kkkkkk')
User.create(name: '吉光', account: 'lll', email: 'l@l', password: 'llllll')
# Unit.create([{:unit_name => '大さじ'},{:unit_name => '小さじ'},{:unit_name => 'カップ'},{:unit_name => 'g'},{:unit_name => 'ml'},{:unit_name => 'L'},{:unit_name => '個'},{:unit_name => '枚'},{:unit_name => '本'},{:unit_name => '少々'},{:unit_name => '1/2'},{:unit_name => '1/4'}])