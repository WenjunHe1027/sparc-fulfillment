class Fulfillment < ActiveRecord::Base

  has_paper_trail
  acts_as_paranoid

  belongs_to :line_item
  belongs_to :service
  belongs_to :creator, class_name: "Identity"
  belongs_to :performer, class_name: "Identity"
  has_one :protocol, through: :line_item

  has_many :components, as: :composable
  has_many :notes, as: :notable
  has_many :documents, as: :documentable

  delegate :quantity_type, to: :line_item

  validates :line_item_id, presence: true
  validates :performer_id, presence: true
  validates :fulfilled_at, presence: true
  validates :quantity, presence: true
  validates_numericality_of :quantity

  after_create :update_line_item_name

  scope :fulfilled_in_date_range, ->(start_date, end_date) {
        where("fulfilled_at is not NULL AND fulfilled_at between ? AND ?", start_date, end_date)}

  def fulfilled_at=(date_time)
    write_attribute(:fulfilled_at, Time.strptime(date_time, "%m-%d-%Y")) if date_time.present?
  end

  def total_cost
    quantity * service_cost
  end

  private

  def update_line_item_name
    # adding first fulfillment to line_item with one time fee?
    if line_item.fulfillments.size == 1 && line_item.one_time_fee
      line_item.set_name
    end
  end
end
