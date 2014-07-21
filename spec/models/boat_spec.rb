require 'spec_helper'

class Boat
attr_reader :collection

  def initialize
    @collection = []
  end

  def receive_item(item)
    collection.push item
  end
end

describe Boat do
  let(:boat) { Boat.new }
  it "has no collection when new" do
    boat.collection.should be_empty
  end

  it "can receive items into its collection" do
    boat.receive_item("fork")
    boat.collection.should include("fork")
  end
end
