require 'rails_helper'


describe Product do

  let(:product) { FactoryGirl.build :product }

  it { should respond_to(:sku) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:capacity) }
  it { should respond_to(:height) }
  it { should respond_to(:diameter) }
  it { should respond_to(:price) }

  # Validation
  it { should validate_presence_of :sku }
  it { should validate_presence_of :title }
  it { should validate_presence_of :price }

end
