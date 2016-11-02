# Options Hashes
#
# Write a method `transmogrify` that takes a `String`. This method should
# take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
# reasonable defaults in a `defaults` hash defined in the `transmogrify`
# method. Use `Hash#merge` to combine the defaults with any optional
# parameters passed by the user. Do not modify the incoming options
# hash. For example:
#
# ```ruby
# transmogrify("Hello")                                    #=> "Hello"
# transmogrify("Hello", :times => 3)                       #=> "HelloHelloHello"
# transmogrify("Hello", :upcase => true)                   #=> "HELLO"
# transmogrify("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# transmogrify("hello", options)
# # options shouldn't change.
# ```

def transmogrify(string, options = {})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }
  options = defaults.merge(options)
    up_word = string.upcase
    rev_wor = string.reverse
    up_rev_word = up_word.reverse


    if options[:upcase] && options[:reverse]
      return up_rev_word * options[:times]
    elsif options[:upcase]
      return up_word * options[:times]
    elsif options[:reverse]
      return rev_word * options[:times]
    else
      return string * options[:times]
    end
end
