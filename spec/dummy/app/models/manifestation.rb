class Manifestation < ActiveRecord::Base
  scope :periodical_master, where(:periodical => false)
  scope :periodical_children, where(:periodical => true)
  has_one :series_has_manifestation, :dependent => :destroy
  has_one :series_statement, :through => :series_has_manifestation
  belongs_to :required_role, :class_name => 'Role', :foreign_key => 'required_role_id', :validate => true

  validates_presence_of :original_title
  validates :isbn, :uniqueness => true, :allow_blank => true, :unless => proc{|manifestation| manifestation.series_statement}
  validates :nbn, :uniqueness => true, :allow_blank => true
  validates :manifestation_identifier, :uniqueness => true, :allow_blank => true
  before_save :set_periodical
  after_save :index_series_statement
  after_destroy :index_series_statement
  normalize_attributes :identifier, :pub_date, :isbn, :issn, :nbn, :lccn, :original_title
  attr_accessor :during_import, :series_statement_id

  def self.per_page
    10
  end

  def convert_isbn
    num = ISBN_Tools.cleanup(isbn) if isbn
    if num
      if num.length == 10
        self.isbn10 = num
        self.isbn = ISBN_Tools.isbn10_to_isbn13(num)
      elsif num.length == 13
        self.isbn10 = ISBN_Tools.isbn13_to_isbn10(num)
      end
    end
  end

  def parent_of_series
    original_manifestations
  end

  def set_serial_information
    return nil unless serial?
    if new_record?
      series = SeriesStatement.where(:id => series_statement_id).first
      manifestation = series.try(:last_issue)
    else
      manifestation = series_statement.try(:last_issue)
    end
    if manifestation
      self.original_title = manifestation.original_title
      self.title_transcription = manifestation.title_transcription
      self.title_alternative = manifestation.title_alternative
      self.issn = manifestation.issn
      # TODO: 雑誌ごとに巻・号・通号のパターンを設定できるようにする
      if manifestation.serial_number.to_i > 0
        self.serial_number = manifestation.serial_number.to_i + 1
        if manifestation.issue_number.to_i > 0
          self.issue_number = manifestation.issue_number.to_i + 1
        else
          self.issue_number = manifestation.issue_number
        end
        self.volume_number = manifestation.volume_number
      else
        if manifestation.issue_number.to_i > 0
          self.issue_number = manifestation.issue_number.to_i + 1
          self.volume_number = manifestation.volume_number
        else
          if manifestation.volume_number.to_i > 0
            self.volume_number = manifestation.volume_number.to_i + 1
          end
        end
      end
    end
    self
  end

  def created(patron)
    creates.where(:patron_id => patron.id).first
  end

  def realized(patron)
    realizes.where(:patron_id => patron.id).first
  end

  def produced(patron)
    produces.where(:patron_id => patron.id).first
  end

  def index_series_statement
    series_statement.try(:index)
  end

  def set_periodical
    unless series_statement
      series_statement = SeriesStatement.where(:id => series_statement_id).first
    end
    if series_statement.try(:root_manifestation)
      self.periodical = true
    end
  end

  def root_of_series?
    return true if series_statement.try(:root_manifestation) == self
    false
  end

  def periodical_master?
    if series_statement
      return true if series_statement.periodical and root_of_series?
    end
    false
  end
end




# == Schema Information
#
# Table name: manifestations
#
#  id                              :integer         not null, primary key
#  original_title                  :text            not null
#  title_alternative               :text
#  title_transcription             :text
#  classification_number           :string(255)
#  identifier                      :string(255)
#  date_of_publication             :datetime
#  date_copyrighted                :datetime
#  created_at                      :datetime
#  updated_at                      :datetime
#  deleted_at                      :datetime
#  access_address                  :string(255)
#  language_id                     :integer         default(1), not null
#  carrier_type_id                 :integer         default(1), not null
#  extent_id                       :integer         default(1), not null
#  start_page                      :integer
#  end_page                        :integer
#  height                          :decimal(, )
#  width                           :decimal(, )
#  depth                           :decimal(, )
#  isbn                            :string(255)
#  isbn10                          :string(255)
#  wrong_isbn                      :string(255)
#  nbn                             :string(255)
#  lccn                            :string(255)
#  oclc_number                     :string(255)
#  issn                            :string(255)
#  price                           :integer
#  fulltext                        :text
#  volume_number_string            :string(255)
#  issue_number_string             :string(255)
#  serial_number_string            :string(255)
#  edition                         :integer
#  note                            :text
#  produces_count                  :integer         default(0), not null
#  exemplifies_count               :integer         default(0), not null
#  embodies_count                  :integer         default(0), not null
#  work_has_subjects_count         :integer         default(0), not null
#  repository_content              :boolean         default(FALSE), not null
#  lock_version                    :integer         default(0), not null
#  required_role_id                :integer         default(1), not null
#  state                           :string(255)
#  required_score                  :integer         default(0), not null
#  frequency_id                    :integer         default(1), not null
#  subscription_master             :boolean         default(FALSE), not null
#  ipaper_id                       :integer
#  ipaper_access_key               :string(255)
#  attachment_file_name            :string(255)
#  attachment_content_type         :string(255)
#  attachment_file_size            :integer
#  attachment_updated_at           :datetime
#  nii_type_id                     :integer
#  title_alternative_transcription :text
#  description                     :text
#  abstract                        :text
#  available_at                    :datetime
#  valid_until                     :datetime
#  date_submitted                  :datetime
#  date_accepted                   :datetime
#  date_caputured                  :datetime
#  ndl_bib_id                      :string(255)
#  file_hash                       :string(255)
#  pub_date                        :string(255)
#  edition_string                  :string(255)
#  periodical                      :boolean         default(FALSE), not null
#  volume_number                   :integer
#  issue_number                    :integer
#  serial_number                   :integer
#

