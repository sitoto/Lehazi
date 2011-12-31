class GridfsController < ActionController::Metal
  def serve
    gridfs_path = env["PATH_INFO"].gsub("/images/", "")
    begin
      @db_conn =  Mongo::Connection.new('mongoc2.grandcloud.cn','10004')
      @db_conn.add_auth('fun', 'lehazi', 'lehazi2011')
      @db = Mongo::DB.new('fun',@db_conn )

      gridfs_file = Mongo::GridFileSystem.new(@db).open(gridfs_path, 'r')
      self.response_body = gridfs_file.read
      self.content_type = gridfs_file.content_type
    rescue Exception => e
      self.status = :file_not_found
      self.content_type = 'text/plain'
      self.response_body = ''
      raise e
    end
  end

end
