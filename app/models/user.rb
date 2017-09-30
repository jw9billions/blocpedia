class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :shared_wikis, through: :collaborators, source: :wiki

  enum role: [:standard, :premium, :admin]

  after_initialize :set_as_standard

  def set_as_standard
    self.role ||= :standard
    #self.role.standard!
  end

  def collaborator_for(wiki)
	  collaborators.where(wiki_id: wiki.id)
  end

=begin
  def premium
    self.role == 'premium' ?
  end
=end

end
