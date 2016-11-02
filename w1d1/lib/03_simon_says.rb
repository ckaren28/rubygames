def echo(word)
  word
end

def shout(word)
  word.upcase
end

def repeat(word, x = 2)
  ([word] * x).join(" ")
end

def start_of_word(word, count)
  word[0...count]
end

def first_word(string)
  string.split[0]
end

LITTLE_WORDS = [
  "and",
  "the",
  "over"
]

def titleize(string)
  words = string.split(" ")
  title_words = words.map.with_index do |word, i|
    if i != 0 && LITTLE_WORDS.include?(word)
      word.downcase 
    else
      word.capitalize
    end
  end
  title_words.join(" ")
end
