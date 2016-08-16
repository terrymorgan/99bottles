def num_to_words number
  words = ""

  if number < 0
    words = words + 'negative '
  end
  if number == 0
    words = 'zero'
  end
  # Each number is parsed into place value slots in an array. Each index position of the array is the exponent of place value.  array[0] is ones, array[1] is tens, array[2] is hundreds, and so on.
  places = number.to_s.reverse.chars

  ones_words = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight','nine']
  tens_words = ['ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
  teens_words = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
  # if array length is multiple of 3, we are speaking in hundreds, whether it's four hundred, four hundred thousand, or four hundrend million.
  # if array length is 2 or 2 plus a mult of 3 then we are speaking in tens, eg thirty four, whether its thirty four thousand, or thirty four million

  special = 0

  while places.length>0 do
    #puts places.to_s + 'length = '+ places.length.to_s

    #HUNDREDS place
    if places.length%3==0  

      if places.last.to_i == 0
        places.pop
      else
        words = words + ones_words[places.pop.to_i-1] + ' hundred '
        non_zero = true
      end

    #TENS place
    elsif places.length==2 or (places.length-2)%3==0 

      if places.last.to_i == 0
        places.pop
      elsif places.last.to_i == 1
        special = places.pop.to_i
        non_zero = true
      else        #not a teen or ten
        words = words + tens_words[places.pop.to_i-1] + " "
        non_zero = true
      end

    #ONES place
    else
      #puts "Before ONES sorting, special = #{special}, places = #{places}, places.last = #{places.last}"
      if special==0 && places.last.to_i == 0
        places.pop
      elsif special==1 && places.last.to_i == 0 # ten
        words = words + tens_words[places.pop.to_i] + " "
        non_zero = true        
      elsif special==1 && places.last.to_i != 0 # a teen
        words = words + teens_words[places.pop.to_i-1] + " "
        non_zero = true
      else
        words = words + ones_words[places.pop.to_i - 1] + " "
        non_zero = true
      end
      special = 0
      #puts "places.length = #{places.length}"
      
      # add seperator if you have at least one non-zero digit in the current triplet. The end of a triplet is after the ones place.
      if places.length%3==0 && non_zero == true        
        separators = ['', 'thousand', 'million', 'billion', 'trillion']
        words = words + separators[places.length/3] + " "
      end
      non_zero = false

    end # place testing if

  end # while
  
  return words.strip
end # method


puts "Lyrics to 99 Bottles of Beer On The Wall!"
puts
puts "You'll be asked for two integers. Then you'll see the opening and closing verses 
plus a random sampling of verses in  between."

start = false
while not start
  print "Let's sing! How many bottles of beer do we have? "
  start = Integer(gets.chomp) rescue false
  if not start
    puts "That was not an integer. Try again."
  end
end

verses = false
while not verses
  print "How many verses do you want to see in addition to the first and last? "
  verses = Integer(gets.chomp) rescue false
  if not verses
    puts "That was not an integer. Try again."
  end
end


sample = [start,1]  
  while sample.length < verses+2 do
    sample.push rand(start-2)+2
    sample = sample.uniq.sort.reverse
  end

sample.each do |num|
  words = num_to_words(num).capitalize

  less_one = num-1
  if less_one == 0
    less_one_words = 'No'
  else
    less_one_words = num_to_words(less_one).capitalize
  end

  if num == 1
    words_s = ""
  else
    words_s = 's'
  end

  if less_one == 1
    less_one_words_s = ""
  else
    less_one_words_s = 's'
  end

  puts
  puts "#{words} bottle#{words_s} of beer on the wall,"
  puts "#{words} bottle#{words_s} of beer,"
  puts "You take one down, you pass it around,"    
  puts "#{less_one_words} bottle#{less_one_words_s} of beer on the wall."

end

puts
puts 'Tada!'