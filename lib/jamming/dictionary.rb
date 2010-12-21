module Jamming
  class Dictionary
    DICTIONARY = {
      "A"  => %w(x02220),
      "Am" => %w(x02210),
      "B"  => %w(x24442),
      "Bm" => %w(x24432),
      "C"  => %w(x32010),
      "Cm" => %w(x35543),
      "D"  => %w(xx0232),
      "Dm" => %w(xx0231),
      "E"  => %w(022100),      
      "Em" => %w(022000),
      "F"  => %w(133211),
      "Fm" => %w(133111),
      "G"  => %w(320022 320002),
      "Gm" => %w(355333)      
    }

    def self.name_for(frets)
      frets = normalize_frets(frets)
      DICTIONARY.each do |key, different_fingerings|
        return key if different_fingerings.include?(frets)
      end
      nil
    end
    
    private
      def self.normalize_frets(frets)
        join_with = frets.any? { |f| f && f >= 10 } ? "-" : ""
        frets.map { |f| f.nil? ? "x" : f.to_s }.join(join_with)
      end
  end
end