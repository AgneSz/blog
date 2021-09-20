class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy

  def username
    return email.split("@")[0].capitalize
  end


  def comment_created
    #This is the same thing as num_comments +=1
    self.number_of_comments = number_of_comments + 1
    save
    number_of_comments
  end
end
