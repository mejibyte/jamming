module Jamming
  class Chord
    attr_reader :frets
    
    def initialize(chord_as_string)
      @frets = parse(chords_as_string)
    end
  
    def to_png(options = {})
      Jamming::PngFormatter.new(self).print(options)
    end
  
    protected
  
    def parse(chord)
      frets = chord.split(chord =~ /-/ ? "-" : "")
      raise ArgumentError.new("'#{chord}' is not a valid chord expression.") unless frets.size == 6
      frets.collect { |f| f =~ /[0-9]+/ ? f.to_i : nil }
    end
  end
end