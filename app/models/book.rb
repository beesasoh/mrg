class Book < ActiveRecord::Base
  attr_accessible :content, :description, :title, :author_id, :subject_id, :published, :book_file

  belongs_to :author
  belongs_to :subject
  has_attached_file :book_file

  validates :title , :presence => 'true'
  validates :author_id, :presence => 'true'
  validates :subject_id, :presence => 'true'
  validates_attachment :book_file, :presence => true,
  										:size => { :in => 1..20.megabytes }
end
