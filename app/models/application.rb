class Application < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum status: { on_hold: "on_hold", accepted: "accepted", rejected: "rejected" }

end
