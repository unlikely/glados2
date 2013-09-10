class AgreementExecution < ActiveRecord::Base
  attr_accessible :person, :agreement_id, :person_id, :agreement, :date_signed, :agreement_url
  belongs_to :person
  belongs_to :agreement

  validates :person, :presence => true
  validates :agreement, :presence => true
  validates :date_signed, :presence => true
  validates :agreement_url, :uniqueness => true, :url => {:allow_blank => false, :message => "Please enter a url in the form of http://www.something.com"}

end
