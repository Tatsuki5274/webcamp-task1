class Message < ApplicationRecord
    validates :text, presence:true,length:{maximum:140}
    belongs_to :sender, class_name: "User"
    belongs_to :reciever, class_name: "User" 
end
