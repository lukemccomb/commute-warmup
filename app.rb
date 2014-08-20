require 'csv-mapper'

@results = CsvMapper.import('./data/gschool_commute_data.csv') do
  start_at_row 1
  [name, week, day, mode, inbound, outbound, distance]
end

# * For Week 4 on Wednesday, what was Nate's inbound commute time?

def nate_wk4_wed
  array = @results.flatten
  groups = array.group_by { |person| person["name"] }
  nate =  groups["Nate"].group_by { |nate| nate["week"] }
  @nate_4 =  nate["4"]
  wed_in = @nate_4.find { |day| day["day"] == "Wednesday" }
  p "Nate's inbound commute time on Wednesday of week 4 was #{wed_in["inbound"].to_i} minutes"
end

nate_wk4_wed

@total = 0
@commutes = 0
@results.map do |row|
  avg = (row["inbound"].to_i + row["outbound"].to_i)
  @total += avg
  @commutes += 2
end


# * For all 5 weeks, what was the group average commute time?

average = @total / @commutes

p "The average commute time for all 5 weeks was #{average} minutes."



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



