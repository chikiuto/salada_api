require 'json'
require 'net/http'
require 'uri'

namespace :bat do
  desc 'update category and recipe table'
  # config/environment.rbを読み込み、環境ごとの設定を反映してから update_category_table を実行
  task update_category_table: :environment do
    uri = URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238')
    API_json_data = Net::HTTP.get(uri)
    hash_data = JSON.parse(API_json_data) # rubyではjsonをhashにして扱う 

    category_ary = [] # category API のデータを入れる配列
    parent_dict = {} # mediumカテゴリの親カテゴリの辞書


    # 大カテゴリ
    hash_data['result']['large'].each do |category|
      list_large = [category['categoryId'],
                    "",
                    "",
                    category['categoryId'],
                    category['categoryName']
                   ]
      category_ary.push(list_large)
    end

    # 中カテゴリ
    hash_data['result']['medium'].each do |category|
      list_medium = [category['parentCategoryId'],
                     category['categoryId'],
                     "",
                     category['parentCategoryId'].to_s + "-" + category['categoryId'].to_s,
                     category['categoryName']
                    ]
      category_ary.push(list_medium)
      parent_dict[category['categoryId'].to_s] = category['parentCategoryId']
    end
    
    # 小カテゴリ
    hash_data['result']['small'].each do |category|
      list_small = [ parent_dict[category['parentCategoryId']],
                     category['parentCategoryId'],
                     category['categoryId'],
                     parent_dict[category['parentCategoryId']].to_s + "-" + category['parentCategoryId'].to_s + "-" + category['categoryId'].to_s,
                     category['categoryName']
                    ]
      category_ary.push(list_small)
    end


    # DBに追加
    category_ary.each do |ary|
      if Category.exists?(category_id: ary[3])
        p "There are already same data '#{ary[4]}'" 
      else
        if ary[4].include?("サラダ")
          category = Category.create(category1: ary[0],
                                     category2: ary[1],
                                     category3: ary[2],
                                     category_id: ary[3],
                                     category_name: ary[4]
                                    )
        end
      end
    end

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # このファイルを実行
    # rails bat:update_category_table
    # seed リセット
    # bin/rails db:reset
    # migration リセット
    # rails db:migrate:reset

    # rails console
    # Category.where("category_name LIKE ?", "%サラダ%")
    # Category.count
    # サンプル抽出
    # Category.all.sample

    # postgreSQL起動
    # $ rails dbconsole
    # 中身確認
    # select * from categories;
    # 行数確認
    # SELECT COUNT(*) FROM categories;

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    recipe_ary = []  # ranking API のデータを入れる配列
    Category.all.each do |cate|
      # 連続でアクセスすると先方のサーバに負荷がかかるので少し待つのがマナー
      sleep(1)
      recipe_uri = URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=1038863537950891238&categoryId='+cate['category_id'])
      recipeAPI_json_data = Net::HTTP.get(recipe_uri)
      
      recipe_hash_data = JSON.parse(recipeAPI_json_data)

      recipe_hash_data['result'].each do |recipe|
        recipe_list = [ recipe['recipeTitle'],
                        recipe['recipeUrl'],
                        recipe['foodImageUrl'],
                        recipe['recipeMaterial'],
                        recipe['recipeCost'],
                        recipe['recipeIndication']
                      ]
        recipe_ary.push(recipe_list)
      end
    end

    # DBに追加
    recipe_ary.each do |ary|
      if Recipe.exists?(title: ary[0])
        p "There are already same data '#{ary[0]}'" 
      else
        category = Recipe.create(title: ary[0],
                                url: ary[1],
                                food_image_url: ary[2],
                                material: ary[3],
                                cost: ary[4],
                                indication: ary[5]
                                )
      end
    end
    
  end
end