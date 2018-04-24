class Dog

    def initialize
        @weight = 0.5
        @age = 1
    end

    def my_weighht
        puts "현재 몸무게 : " + @weight.to_s
    end
       
    def eat
        @weight += 0.5
        puts "먹는다."
    end

    def run
        puts "뛴다."
    end

    def walk
        puts "걷는다."
    end

end

cDog = Dog.new

cDog.my_weighht
cDog.eat
cDog.my_weighht