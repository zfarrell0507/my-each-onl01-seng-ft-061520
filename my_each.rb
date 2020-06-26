    words = ['hi', 'hello', 'bye', 'goodbye']
def my_each(words)
  if block_given?
    counter = 0 
    while counter < words.length 
      yield words[counter]
      counter += 1
    end 
    words
  end 
end
   my_each(['hi', 'hello', 'bye', 'goodbye']) do |word|
      puts word
    end
