module Concerns::Findable
    def find_by_name(name)
        all.detect{|t| t.name == name}
    end 

    def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end


    def sort_songs
        counter = 1
        sorted_array = self.all.uniq.sort_by{|t|t.name}
        sorted_array.map do |u|
          puts "#{counter}. #{u.name}"
          counter += 1
         end

    end

end 