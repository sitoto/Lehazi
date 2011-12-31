class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :articles
  has_many :infos
  has_many :funs
  has_many :entries
  has_many :comments

  #portrait
  mount_uploader :portrait_location, PortraitUploader


  attr_accessible :login, :email, :password, :password_confirmation,:current_login_ip
  attr_protected :enabled,:crypted_password
  attr_accessor :password

  before_save :encrypt_password
  before_create :set_some_att
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def set_some_att
    self.perishable_token = 'abc'
    self.persistence_token = DateTime.now().to_s
    self.single_access_token= 'def'
    #self.current_login_ip  = :current_login_ip #request.remote_ip #IPSocket.getaddress(Socket.gethostname)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.crypted_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.crypted_password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def has_roles?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end

  def email_with_login
    "#{login} <#{email}>"
  end
end
