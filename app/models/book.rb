class Book < ActiveRecord::Base
  attr_accessible :content, :description, :title, :author_id, :subject_id, :published, :book_file

  belongs_to :author
  belongs_to :subject
  has_attached_file :book_file

  validates_presence_of :title, :author_id, :subject_id, :book_file
  validates_attachment :book_file, :size => { :in => 1..20.megabytes }
end
