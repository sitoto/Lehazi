
#suda服务器
CarrierWave.configure do |config|
  config.grid_fs_database = 'fun'    #数据库名
  config.grid_fs_host = 'mongoc2.grandcloud.cn'     #mongodb地址
  config.storage = :grid_fs
  config.grid_fs_port = "10004"
  config.grid_fs_username = "lehazi"
  config.grid_fs_password = "lehazi2011"
  config.grid_fs_access_url = "/images" #访问时图片url的前缀
end
