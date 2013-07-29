# Used to create time and datetime formatting short cuts. Search for to_formatted_s in the api
# Also see http://snippets.dzone.com/posts/show/2406

# If date = Time.local(2009,12,24,15,30,27)

Time::DATE_FORMATS[:datetime] = "%H:%M %d-%b-%Y"  # date.to_s(:datetime)  ---->  15:30 24-Dec-2009
Time::DATE_FORMATS[:date] = "%d-%b-%Y"            # date.to_s(:date)      ---->  24-Dec-2009
Time::DATE_FORMATS[:time] = "%H:%M"               # date.to_s(:time)      ---->  15:30
Time::DATE_FORMATS[:google] = "%Y-%m-%d %H:%M:%S" # date.to_s(:google)    ---->  2009-12-24 15:30:27
Time::DATE_FORMATS[:filename] = "at_%H_%M_on_%d_%b_%Y"