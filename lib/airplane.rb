class Airplane

  attr_reader :type, :wing_loading, :horsepower
  attr_accessor :engine_state, :flying, :fuel

  def initialize(type, wing_loading, horsepower)
    @type = type
    @wing_loading = wing_loading
    @horsepower = horsepower
    @engine_state = 'off'
    @flying = false
    @fuel = 100
  end

  def start
    if @engine_state == 'on' && @fuel > 20
      print 'The engine has already been started'
    elsif @fuel < 20
      fuel_error
    else
      @engine_state = 'on'
      @fuel -= 20
      print 'Airplane started!'
    end
  end

  def takeoff
    if @engine_state == 'on' && @fuel > 20
      if @flying == false
        @flying = true
        @fuel -= 20
        print "Airplane taking off!"
      else
        print "Airplane is already in the air"
      end
    elsif @engine_state == "off"
      print "The plane needs to start before it can take off"
    elsif @fuel < 20
      fuel_error
    end
  end

  def land
    if @engine_state == 'on' && @fuel > 20
      if @flying == true
        @flying = false
        @fuel -= 20
        print "Airplane landing"
      else
        print "Airplane is already grounded"
      end
    elsif @engine_state == 'off'
      print "The plane is not even turned on yet!"
    elsif @fuel < 20 && @flying == true
      fuel_error
    end
  end

  def check_fuel
    @fuel
  end

  def set_fuel=(current_fuel)
    @fuel = current_fuel
  end

  def fuel_error
    print "ERROR: NOT ENOUGH FUEL"
  end

end
