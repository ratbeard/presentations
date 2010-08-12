module Song  
  class Note
    def initialize(note)
      @note = note
    end
    
    # Make a note sharp or flat:  `+note` or `-note`
    def +@
      @sharp, @flat = true, false
      self
    end
        
    def -@
      @sharp, @flat = false, true
      self
    end

    def play
      modifier = @sharp && '#' || @flat && 'b'
      puts "#{@note}#{modifier}"
    end
  end
  
  
  class Song
    def initialize
      @name   = "Untitled" 
      @notes  = []
      @tempo  = 100
    end
    
    def name(name)    @name  = name   end
    def tempo(tempo)  @tempo = tempo  end
    def notes(*notes) @notes = notes  end
    
    def play
      puts "Playing '#@name'"
      @notes.each do |note| 
        note.play
        sleep 60.0 / @tempo
      end
      puts "Crowd cheers!"
    end
    
    def method_missing(name, *args, &block)
      Note.new(name) 
    end
  end
  
  def self.play(&block)
    song = Song.new
    song.instance_eval(&block)
    song.play
    song
  end
end

Song.play do
  name "Chill Tune"
  tempo 280
  notes  c6, -g6,  __,  d5,
         c6, +g6,  a2,  d5
end
