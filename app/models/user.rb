class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #, :confirmable
  has_many :wikis, dependent: :destroy
  enum role: [:standard, :premium, :admin]

=begin
  after_initialize do
    user.role.standard!
  end

  def premium
    self.role == 'premium' ?
  end
=end

end
