class Form::GliderFlightCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  USER_NUM = 10  # 同時にフライトを作成する数
  attr_accessor :collection # ここに作成したglider_flightsモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [], pilot_id)
    self.collection = if attributes.present?
                        attributes.map do |value|
                          fleet = Fleet.find_by(id: value.fleet)
                          GliderFlight.new(
                            date: value.date,
                            # glider_type: get_glider_type(fleet.aircraft_type_id),
                            glider_type: fleet.aircraft_type_id,
                            glider_ident: fleet.ident,
                            departure_and_arrival_point: value.departure_and_arrival_point,
                            number_of_landing: 1,
                            takeoff_time: value.takeoff_time,
                            landing_time: value.landing_time,
                            flight_role: get_flight_role(value, pilot_id),
                            is_winch: value.is_winch,
                            release_alt: value.release_alt,
                            note: value.notes
                          )
                        end
                      else
                        USER_NUM.times.map{ GliderFlight.new }
                      end
  end

  # def get_glider_type(aircraft_type_id)
  #   binding.pry
  #   glider_type = AircraftType.find_by(id: aircraft_type_id)
  #   glider_type.aircraft_type
  # end

  def get_flight_role(value, pilot_id)
    case pilot_id
    when value.front_seat
      value.front_flight_role
    when value.rear_seat
      value.rear_flight_role
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end
end
