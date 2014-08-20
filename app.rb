require 'csv'

# * For Week 4 on Wednesday, what was Nate's inbound commute time?

commutes_csv = CSV.open('./data/gschool_commute_data.csv', :headers => true, :header_converters => :symbol, :converters => :all)
commuters_array = commutes_csv.to_a
commuters_hash = commuters_array.map { |row| row.to_hash }
groups = commuters_hash.group_by { |day| day[:person] }
nate = groups["Nate"].group_by { |nate| nate[:week] }
nate_wk4 = nate[4]
wed_inbound = nate_wk4.find {|day| day[:day] == "Wednesday" }
wed_inbound[:inbound]
p "Nate's inbound commute time on Wednesday of week 4 was #{wed_inbound[:inbound]} minutes"

# * For all 5 weeks, what was the group average commute time?

@total = 0
@commutes = 0
commuters_hash.each do |row|
  avg = (row[:inbound] + row[:outbound])
  @total += avg
  @commutes += 2
end

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



