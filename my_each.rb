    words = ['hi', 'hello', 'bye', 'goodbye']
    counter = 0
def my_each
  
  
  
  # code here
end

=========================================================================================
def hello_t(array)
  if block_given?
  i = 0
  while i < array.length 
    yield array[i]
    i = i + 1 
  end 
  array
  
  else 
    puts "Hey! No block was given!"
  end
end

# call your method here!
hello_t(["Tim", "Tom", "Jim"]) do |name|
  if name.start_with?("T")
    puts "Hi, #{name}"
  end
end
=========================================================================================



describe "my_each" do
  file = File.read('./my_each.rb')

  it "does not call on .each" do
    expect(file).to_not include(".each")
    expect(file).to_not include("puts")
    expect(file).to include("while")

  it "iterates over each element" do
    words = ['hi', 'hello', 'bye', 'goodbye']

    # This line tests that each word gets printed out by the loop!
    expect($stdout).to receive(:puts).exactly(words.length).times
    my_each(words) do |word|
      puts word
    end
  end

  it 'yields the correct element' do
    words = ['hi', 'hello', 'bye', 'goodbye']
    counter = 0

    my_each(words) do |item|
      expect(item).to equal(words[counter])
      counter+=1
    end
  end

  it "can handle an empty collection" do
    empty_array = []

    saved_block = Proc.new {
      my_each(empty_array) do |x|
        raise "This block should not run!"
      end
    }

    expect(saved_block).to_not raise_error
  end

  it "returned array contains the same elements as the original collection" do
    tas = ['arel', 'jon', 'logan', 'spencer']

    # run the method
    expect(my_each(tas) do |ta|
    # Do nothing on yield
    # check if it returns correct values
    end).to contain_exactly('arel', 'jon', 'logan', 'spencer')
  end

  it "does not modify the original collection" do
    tas = ['arel', 'jon', 'logan', 'spencer']
    # array may be modified by the iteration function so
    # we cannot use it for verifying the results
    # therefore we create a new copy using the clone method
    tas_original = tas.clone

    # run the method
    my_each(tas) do |ta|
      ta = "testing 1 2 3"
    end

    # is verifying if the array we passed to method
    # has not been modified
    expect(tas).to eq(tas_original)
  end

  it "block is run n times" do
    tas = ['arel', 'jon', 'logan', 'spencer']
    expected = tas.length
    times_called = 0

    my_each(tas) do |ta|
      times_called += 1
    end

    expect(times_called).to eq(expected)
  end

  it "only passes a single element into the block at a time" do

    tas = ['arel', 'jon', 'logan', 'spencer']

    my_each(tas) do |ta|
      # ta cannot be an array
      expect(ta.kind_of?(Array)).to eq(false)
      expect(ta.kind_of?(String)).to eq(true)
    end
  end
end