module Form
  class GliderFlightCollection
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    extend ActiveModel::Callbacks
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations

    # FLIGHT_NUM = 10  # 同時にフライトを作成する数
    attr_accessor :collection # ここに、作成したgliderflightsモデルが格納される

    # 初期化メソッド
    def initialize(attributes, pilot, init_type)
      self.collection = case init_type
                        when 'create'
                          attributes.map do |value|
                            pilot.gliderflights.build(
                              date: value['date'],
                              aircraft_type_id: value['aircraft_type_id'],
                              glider_ident: value['glider_ident'],
                              departure_point: value['departure_point'],
                              arrival_point: value['arrival_point'],
                              number_of_landing: value['number_of_landing'],
                              takeoff_time: value['takeoff_time'],
                              landing_time: value['landing_time'],
                              flight_role: value['flight_role'],
                              is_winch: value['is_winch'],
                              release_alt: value['release_alt'],
                              note: value['note']
                            )
                          end
                        when 'new'
                          attributes.map do |value|
                            pilot_id = pilot.id
                            # フライト区分を取得（「ログ対象外」除外用）
                            flight_role = if value.front_seat == pilot_id
                                            value.front_flight_role
                                          elsif value.rear_seat == pilot_id
                                            value.rear_flight_role
                                          end
                            # 遊覧飛行以外の場合
                            next unless flight_role != "ログ対象外"

                            fleet = Fleet.find_by(id: value.fleet)
                            pilot.gliderflights.build(
                              date: value.date,
                              aircraft_type_id: fleet.aircraft_type_id,
                              glider_ident: fleet.ident,
                              departure_point: value.departure_point,
                              arrival_point: value.arrival_point,
                              number_of_landing: 1,
                              takeoff_time: value.takeoff_time,
                              landing_time: value.landing_time,
                              flight_role: get_flight_role(value, pilot_id),
                              is_winch: value.is_winch,
                              release_alt: value.release_alt,
                              note: value.note
                            )
                          end
                        end
    end

    def get_flight_role(value, pilot_id)
      case pilot_id
      # 前席に登場していた場合
      when value.front_seat
        case value.front_flight_role
        when "機長", "単独飛行", "同乗教育"
          value.front_flight_role
        when "教官"
          "機長"
        end
      # 後席に搭乗していた場合
      when value.rear_seat
        case value.rear_flight_role
        when "機長", "同乗教育"
          value.front_flight_role
        when "教官"
          "機長"
        end
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
    rescue StandardError
      Rails.logger.debug 'フライトログの保存中にエラーが発生しました。'
    ensure
      return is_success
    end

    # レコードが存在するか確認するメソッド
    def persisted?
      false
    end
  end
end
