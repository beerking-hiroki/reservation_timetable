# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

store = Store.find_or_create_by!(email: 'example@email.com') do |s|
  s.name = 'テスト店'
  s.password = 'password'
  s.open_time = "9:00"
  s.close_time = "5:00"
  # close_timeがopen_timeより小さい場合は翌日の閉店(例:9:00-翌5:00)
end


rooms = { '101' => 2, '209' => 2, '231' => 10 }
rooms.each do |name, capacity|
  store.rooms.find_or_create_by!(name: name) do |r|
    r.capacity = capacity
  end
end

# 予約
room = store.rooms.find_by!(name: '101')
now = Time.zone.now

room.slots.find_or_create_by!(kind: :reservation, start_at: now.change(hour: 13)) do |s|
  s.name = 'テスト'
  s.tel = '090-0000-0000'
  s.headcount = 2
  s.plan = '2時間'
  s.end_at = now.change(hour: 15)
end

# ウォークイン
room = store.rooms.find_by!(name: '209')

room.slots.find_or_create_by!(kind: :walk_in, start_at: now.change(hour: 10)) do |s|
  s.status = :checked_in
  s.headcount = 2
  s.end_at = now.change(hour: 12)
end

# ブロック
room = store.rooms.find_by!(name: '231')

room.slots.find_or_create_by!(kind: :block, start_at: now.change(hour: 19)) do |s|
  s.end_at = now.change(hour: 21)
end
