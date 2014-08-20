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

# **Extra Credit**
# * Who walked the fastest to gSchool during the 5 weeks? What was their average speed?

walkers = commuters_hash.group_by { |day| day[:mode] }
who_walks  = walkers["Walk"].group_by { |walker| walker[:person] }
#  Emily
emily = who_walks["Emily"]
@em_total_in = 0
@em_days = 0
emily.each do |day|
  @em_total_in += day[:inbound]
  @em_days += 1
end
em_avg_walk_time = @em_total_in / @em_days
em_avg_speed = em_avg_walk_time / emily.first[:distance]
p "Emily walked at an average speed of #{em_avg_speed} minutes per mile"

# Rachel
rachel = who_walks["Rachel"]
@ra_total_in = 0
@ra_days = 0
rachel.each do |day|
  @ra_total_in += day[:inbound]
  @ra_days += 1
end
ra_avg_walk_time = @ra_total_in / @ra_days
ra_avg_speed = ra_avg_walk_time / rachel.first[:distance]
p "Rachel walked at an average speed of #{ra_avg_speed} minutes per mile"

if ra_avg_speed > em_avg_speed
  p "Rachel was the fastest walker with an average speed of #{ra_avg_speed} minutes per mile."
else
  p "Emily was the fastest walker with an average speed of #{em_avg_speed} minutes per mile."
end