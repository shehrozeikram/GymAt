# == Schema Information
#
# Table name: businesses
#
#  id             :bigint           not null, primary key
#  ar_description :string
#  ar_title       :string
#  title          :string
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Business, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
