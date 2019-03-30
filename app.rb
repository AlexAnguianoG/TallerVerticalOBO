require 'car_factory'

include CarFactory

# Database connection
Database.load(db_file: 'db.yml')  

# Which fields are available

civic = Car.new(
  brand:        "Honda",
  name:         "Civic",
  tires:        "Continental",
  motor:        "Turbo 2.5",
  transmission: "Manual",
  doors:        4,
  style:        "Sedan"
)

accord = Car.new(
  brand:        "Honda",
  name:         "Accord",
  tires:        "Michelin",
  motor:        "Non Turbo 2.0",
  transmission: "Automatic",
  doors:        3,
  style:        "Hashback"
)

def calcular_civic(civic)
  [Inventory.continental_tires / 4 , Inventory.motors_with_turbo, Inventory.doors / 4, Inventory.manual_transmissions].min
end

def calcular_accord(accord)
  [Inventory.michelin_tires / 4, Inventory.motors_with_no_turbo, Inventory.doors / 3, Inventory.automatic_transmissions].min
end


# How to build a car object

civic_array = Array.new(calcular_civic(civic), civic)

accord_array = Array.new(calcular_accord(accord), accord)


# Post result to validator
resultCivic = Transport.post_result(
  team:       10,
  total:      calcular_civic(civic),
  cars:       civic_array
)

puts resultCivic.body.inspect

resultAccord = Transport.post_result(
  team:       10,
  total:      calcular_accord(accord),
  cars:       accord_array
)

puts resultAccord.body.inspect
