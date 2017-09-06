class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  after_initialize :initialize_role

  private

  def initialize_role
    self.private = false if (user.role == 'standard')
  end

  default_scope {order('created_at DESC')}
end
