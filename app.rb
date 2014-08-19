require 'csv-mapper'

@results = CsvMapper.import('./data/gschool_commute_data.csv') do
  start_at_row 1
  [name, week, day, mode, inbound, outbound, distance]
end

# p results
# p nate_4

def nate_inbound_wk4
  array = @results.flatten
  groups = array.group_by { |person| person["name"] }
  nate =  groups["Nate"].group_by { |nate| nate["week"] }
  @nate_4 =  nate["4"]
  @inbound_tote = 0
  @nate_4.each do |day|
    @inbound_tote += day["inbound"].to_i
  end
  p @inbound_tote
end

nate_inbound_wk4

p (@results.first["inbound"].to_i + @results.first["outbound"].to_i)

@total = 0
@commutes = 0
@results.map do |row|
  avg = (row["inbound"].to_i + row["outbound"].to_i)
  @total += avg
  @commutes += 2
end

average = @total / @commutes

p average



# results.each do |person|
#   hash = {}
#   hash[person.name] = []
# end

# p results
#
# p results.first.first_name
# p results.first.week
# p results.first.day
# p results.first.mode
# p results.first.inbound
# p results.first.outbound
# p results.first.distance



