require_relative 'spec_helper'

describe Robot do

  before(:each) do
    @robot1 = Robot.new
    @robot2 = Robot.new
  end

  describe "#shield" do
    it "starts with shield" do
      expect(@robot1.shield).to eq(50)
    end

    it "decrease shield first if attacked" do
      @robot2.attack(@robot1)
      expect(@robot1.shield).to eq(45)
    end

    it "decrease health when attack power is greater than shield left" do
      # allow(@robot1).to receive(:shield).and_return(3)
      11.times do 
        @robot2.attack(@robot1)
      end
      expect(@robot1.health).to eq(95)
      expect(@robot1.shield).to eq(0)
      # expect(@robot1.shield).to eq(0)
    end
  end

end

