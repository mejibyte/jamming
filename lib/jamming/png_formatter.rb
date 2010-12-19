require 'rvg/rvg' # rmagick's RVG (Ruby Vector Graphics) 

module Jamming
  Magick::RVG::dpi = 72
  # Formats a single fingering as png data
  class PNGFormatter

    def initialize(frets)
      @frets = frets
      @open_notes = ["E", "A", "D", "G", "B", "e"]
    end

    def print(opts={})
      
      @max_fret = @frets.compact.max
      @min_fret = @frets.compact.delete_if { |f| f == 0 }.min

      @max_dist = [@max_fret - @min_fret + 1, 3].max

      get_png_data
    end

    private

    def get_png_data
      rvg = Magick::RVG.new(5.cm, 5.cm).viewbox(0,0,270,250) do |canvas|
        canvas.background_fill = 'white'
        x_div = @open_notes.size - 1

        y_diff = 215 / (@max_dist + 1)

        (@max_dist+2).times do |n|
          canvas.line(20, n*y_diff+20, 250, n*y_diff+20)
        end

        @open_notes.each_with_index do |note, i|
          canvas.line(i*(230/x_div)+20, 20, i*(230/x_div)+20, 230)

          unless [0,nil].include?(@frets[i])
            canvas.circle(15, i*(230/x_div)+20,
            (@frets[i] - @min_fret + 1)*y_diff - 5)
          end

          canvas.text(i*(230/x_div)+20, 15) do |txt| 
            txt.tspan((@frets[i] || 'x').to_s).styles(
            :text_anchor => 'middle',
            :font_size => 20, 
            :font_family => 'helvetica',
            :fill => 'black')
          end
          canvas.text(i*(230/x_div)+20, 249) do |txt| 
            txt.tspan(note).styles(:text_anchor => 'middle',
            :font_size => 18, 
            :font_family => 'helvetica',
            :fill => 'black')
          end
        end

      end
      img = rvg.draw
      img.format = 'PNG'
      img.to_blob
    end
  end

end