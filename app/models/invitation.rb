class Invitation < ApplicationRecord
    belongs_to :invite_sender, class_name: "User"
    belongs_to :invite_receiver, class_name: "User"
    belongs_to :event 
end
