class User < ActiveRecord::Base
  paginates_per 10

  has_many :transactions, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :invests, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token


  validates_presence_of :name, message: '不能为空'
  validates_presence_of :email, message: '不能为空'
  validates :name, :length=>{ maximum: 50, too_long: '太长了' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format: { with: VALID_EMAIL_REGEX, :message => '格式不正确' },
            uniqueness: { case_sensitive: false }
  validates_length_of :password,
                      :within => 6..16,
                      message: '长度不正确，应该在6到16位之间',
                      on: :create

  # rails自带
  has_secure_password

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  # 修改密码
  attr_reader :current_password
  def update_password(user_params)
    current_password = user_params.delete(:current_password)

    # 旧密码判断
    unless self.authenticate(current_password)
      self.errors.add(:current_password, current_password.blank? ? '旧密码不能为空' : '旧密码输入不正确')
      return false
    end

    # 新密码空值判断
    unless user_params[:password].present?
      self.errors.add(:password, '请输入新密码')
      return false
    end

    # 新密码长度判断
    unless user_params[:password].length.between?(6,16)
      self.errors.add(:password, '新密码长度不正确，应该在6到16位之间')
      return false
    end
    
    self.update(user_params)
  end

  def admin?
    self.role == 'admin'
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
