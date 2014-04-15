class AgreementExecution < ActiveRecord::Base
  attr_accessible :person, :agreement_id, :person_id, :agreement, :date_signed, :agreement_url, :picture
  belongs_to :person
  belongs_to :agreement

  validates :person, :presence => { :message => "A person needs to be associated" }
  validates :agreement, :presence => { :message => "An agreement is required" }
  validates :date_signed, :presence => { :message => "The date is required" }
  validates :agreement_url, :uniqueness => {message: "The url you entered is already in the system" } , :url => {:allow_blank => false, :message => "Please enter a url in the form of http://www.something.com"}

end
