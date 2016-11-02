def reverser(&prc)
  sentence = prc.call
  words = sentence.split(" ")
    words.map {|word| word.reverse}.join(" ")
end

def adder(num = 1, &prc)
  prc.call + num
end

def repeater(n = 1, &prc)
  n.times &prc
end
