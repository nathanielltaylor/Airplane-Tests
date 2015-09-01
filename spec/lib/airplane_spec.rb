require_relative "../../lib/airplane"


describe Airplane do
  let(:airplane) { Airplane.new("cesna", 10, 150) }

  describe "#initialization" do
    it "has a type" do
      expect(airplane.type).to eq "cesna"
    end

    it "has a wing load" do
      expect(airplane.wing_loading).to eq 10
    end

    it "has a horsepower" do
      expect(airplane.horsepower).to eq 150
    end

    it "is initialized as off" do
      expect(airplane.engine_state).to eq "off"
    end

    it "is initialized as grounded" do
      expect(airplane.flying).to eq false
    end
  end

  ###########################
  describe "#set_fuel=()" do
    it "can reset the plane's fuel" do
      airplane.set_fuel=(50)
      expect(airplane.fuel).to eq 50
    end
  end

  ###########################
  describe "#fuel_error" do
    it "prints an error" do
      expect {airplane.fuel_error}.to output("ERROR: NOT ENOUGH FUEL").to_stdout
    end
  end

  ###########################
  describe "#land" do
    it "lands if it is in the air" do
      airplane.start
      airplane.takeoff
      expect { airplane.land }. to output("Airplane landing").to_stdout
      expect(airplane.flying). to eq false
    end

    it "gives error if plane is on but already grounded" do
      airplane.start
      expect { airplane.land }. to output("Airplane is already grounded").to_stdout
      expect(airplane.flying). to eq false
    end

    it "gives different error if plane's engines are off" do
      expect { airplane.land }. to output("The plane is not even turned on yet!").to_stdout
    end

    it "gives an error if landing is attempted without any fuel and remains airborne" do
      airplane.set_fuel=(50)
      airplane.start
      airplane.takeoff
      expect { airplane.land }.to output(airplane.fuel_error).to_stdout
      expect(airplane.flying).to eq true
    end

  end

  ###########################
  describe "#takeoff" do

    it "takes off if engine is on" do
      airplane.start
      expect { airplane.takeoff }.to output("Airplane taking off!").to_stdout
      expect(airplane.flying).to eq true
    end

    it "gives error if plane tries to take off with engine off" do
      airplane.takeoff
      expect { airplane.takeoff }.to output("The plane needs to start before it can take off").to_stdout
      expect(airplane.flying).to eq false
    end

    it "informs user if plane is already in the air" do
      airplane.start
      airplane.takeoff
      expect { airplane.takeoff }.to output("Airplane is already in the air").to_stdout
    end

    it "gives an error if takeoff is attempted without any fuel and stays on the ground" do
      airplane.set_fuel=(10)
      expect { airplane.takeoff }.to output(airplane.fuel_error).to_stdout
      expect(airplane.flying).to eq false
    end

  end

  ###########################
  describe "#start" do

    it "can be turned on" do
      expect { airplane.start }.to output('Airplane started!').to_stdout
      expect(airplane.engine_state).to eq "on"
    end

    it "knows when its already on" do
      airplane.start
      expect { airplane.start }.to output('The engine has already been started').to_stdout
    end

    it "gives an error if it is started without any fuel and does not start" do
      airplane.set_fuel=(10)
      expect { airplane.start }.to output(airplane.fuel_error).to_stdout
      expect(airplane.engine_state).to eq "off"
    end
  end

end
