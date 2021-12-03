class BitCounter

    def initialize(@input : Array(String))
        @count=Array(Hash(Char,Int32)).new
        (0..11).each do
            @count << Hash(Char,Int32).new(0)
        end
    end

    def count
        @input.each do |s|
            s.each_char_with_index do |c,i|
                @count[i][c]+=1
            end
        end
    end

    def most_frequent_bitstring
        result=Array(String).new
        @count.each do |h| 
            result << "1" if h['1']>=h['0']
            result << "0" if h['0']>h['1']
        end
        result.join ""
    end

    def less_frequent_bitstring
        result=Array(String).new
        @count.each do |h| 
            result << "1" if h['1']<h['0']
            result << "0" if h['0']<=h['1']
        end
        result.join ""
    end
end

def filter(array,flag)
    result=array.clone
    p=0
    while result.size>1
        b=BitCounter.new(result)
        b.count
        if flag==:most
            bitstring=b.most_frequent_bitstring
        else
            bitstring=b.less_frequent_bitstring
        end
        result.select!{|s| s[p]==bitstring[p]}
        p+=1
    end
    return result[0].to_i(base: 2)
end

input=Array(String).new
File.each_line("../input.txt") do |line|
    input<<line.strip
end

b=BitCounter.new(input)
b.count
gamma=b.most_frequent_bitstring.to_i(base: 2)
epsilon=b.less_frequent_bitstring.to_i(base: 2)

puts "Part1: gamma=#{gamma}, epsilon=#{epsilon}, product=#{gamma*epsilon}"

oxygen=filter(input,:most)
co2=filter(input,:less)

puts "Part2: oxygen=#{oxygen}, co2=#{co2}, product=#{oxygen*co2}"

