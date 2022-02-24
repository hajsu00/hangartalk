class Form::GliderFlightCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  extend ActiveModel::Callbacks
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations

  FLIGHT_NUM = 10  # 同時にフライトを作成する数
  attr_accessor :collection # ここに、作成したglider_flightsモデルが格納される

  # 初期化メソッド
  def initialize(attributes, pilot, init_type)
    self.collection = if init_type == 'create'
                        attributes.map do |value|
                          pilot.glider_flights.build(
                            date: value['date'],
                            glider_type: value['glider_type'],
                            glider_ident: value['glider_ident'],
                            departure_and_arrival_point: value['departure_and_arrival_point'],
                            number_of_landing: value['number_of_landing'],
                            takeoff_time: value['takeoff_time'],
                            landing_time: value['landing_time'],
                            flight_role: value['flight_role'],
                            is_winch: value['is_winch'],
                            release_alt: value['release_alt'],
                            note: value['note']
                          )
                        end
                      elsif init_type == 'new'
                        attributes.map do |value|
                          fleet = Fleet.find_by(id: value.fleet)
                          pilot.glider_flights.build(
                            date: value.date,
                            glider_type: fleet.aircraft_type_id,
                            glider_ident: fleet.ident,
                            departure_and_arrival_point: value.departure_and_arrival_point,
                            number_of_landing: 1,
                            takeoff_time: value.takeoff_time,
                            landing_time: value.landing_time,
                            flight_role: get_flight_role(value, pilot.id),
                            is_winch: value.is_winch,
                            release_alt: value.release_alt,
                            note: value.notes
                          )
                        end
                      end
  end

  def get_flight_role(value, pilot_id)
    case pilot_id
    when value.front_seat
      value.front_flight_role
    when value.rear_seat
      value.rear_flight_role
    end
  end

  # コレクションをDBに保存するメソッド
  def save_collection
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue
      p 'フライトログの保存中にエラーが発生しました。'
    ensure
      return is_success
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end
end
