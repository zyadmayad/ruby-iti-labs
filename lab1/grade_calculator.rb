print "How many scores? "

n = gets.chomp.to_i

max = avg = 0.0
min = 100

n.times {|i| 
    print "Enter score #{i+1}: "
    sc = gets.chomp.to_f
    
    while sc < 0 or sc > 100
        puts "Score range is [0 - 100]."
        print "Enter score #{i+1}: "
        sc = gets.chomp.to_f
    end
    
    
    if sc<min
        min = sc
    end
    if sc>max
        max = sc
    end

    avg += sc/n

}


if avg < 60
    grade = 'F'
elsif avg <= 70
    grade =  'D'
elsif avg < 80
    grade =  'C'
elsif avg < 90
    grade = 'B'
else
    grade = 'A'
end

puts "Results:"
puts "\tAverage: #{avg}"
puts "\tGrade: #{grade}"
puts "\tHighest: #{max}"
puts "\tLowest: #{min}"
