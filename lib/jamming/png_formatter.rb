require 'rvg/rvg' # rmagick's RVG (Ruby Vector Graphics) 

module Jamming
  Magick::RVG::dpi = 72
  # Formats a single fingering as png data
  class PNGFormatter

    def initialize(frets)
      @frets = frets
      @strings = ["E", "A", "D", "G", "B", "e"]
    end

    def print(options={})
      @label = options[:label]
      
      @max_fret = @frets.compact.max
      @min_fret = @frets.compact.delete_if { |f| f == 0 }.min
      @min_fret = 1 if @max_fret < 4

      @max_dist = [@max_fret - @min_fret + 1, 3].max
      
      get_png_data
    end

    private

    def get_png_data
      width = 400
      height = 300
      
      rvg = Magick::RVG.new(400, 300).viewbox(0,0,width,height) do |canvas|
        canvas.background_fill = 'white'
        x_div = @strings.size - 1
        
        width_of_chord = 280
        margin_side_of_chord = (width - width_of_chord) / 2

        height_of_chord = 200
        margin_top_of_chord = ((height - height_of_chord) * 2 / 3.0).floor
        margin_bottom_of_chord = ((height - height_of_chord) / 3.0).ceil
        
        height_of_fret = height_of_chord / (@max_dist + 1)
        radius_of_finger = (height_of_fret * 0.6) / 2
        
        width_of_fret = width_of_chord / x_div

        # Draw all horizontal lines
        (@max_dist+2).times do |n|
          canvas.line(margin_side_of_chord, n*height_of_fret+margin_top_of_chord, width - margin_side_of_chord, n*height_of_fret+margin_top_of_chord)
        end
        
        (@max_dist+1).times do |i|
          canvas.text(margin_side_of_chord - 16, i*height_of_fret+margin_top_of_chord + height_of_fret / 2 + 10) do |txt|
            txt.tspan(@min_fret + i).styles(
              :text_anchor => 'end',
              :font_size => 24,
              :font_family => 'helvetica',
              :fill => 'black')
          end
        end

        @strings.each_with_index do |note, i|
          # Draw vertical lines
          canvas.line(i*width_of_fret+margin_side_of_chord, margin_top_of_chord, i*width_of_fret+margin_side_of_chord, height - margin_bottom_of_chord)

          
          if [0,nil].include?(@frets[i])
            # Add a text at the top. Either an X or O
            canvas.text(i*width_of_fret+margin_side_of_chord, margin_top_of_chord - 6) do |txt| 
              txt.tspan((@frets[i] == 0 ? "O" : 'X').to_s).styles(
              :text_anchor => 'middle',
              :font_size => 24, 
              :font_family => 'helvetica',
              :fill => 'black')
            end            
          else
            # Add a finger
            canvas.circle(radius_of_finger, i*width_of_fret+margin_side_of_chord,
            (@frets[i] - @min_fret + 1)*height_of_fret - (height_of_fret / 2) + margin_top_of_chord)
          end
          
          canvas.text(i*width_of_fret+margin_side_of_chord, height - margin_bottom_of_chord + 20) do |txt| 
            txt.tspan(note).styles(:text_anchor => 'middle',
            :font_size => 18, 
            :font_family => 'helvetica',
            :fill => 'black')
          end
        end
        
        if @label
          canvas.text(width / 2, margin_top_of_chord / 2) do |txt|
            txt.tspan(@label).styles(:text_anchor => 'middle',
              :font_size => 36,
              :font_family => 'helvetica',
              :fill => 'black',
              :font_weight => 'bold',
            )
          end
        end

      end
      img = rvg.draw
      img.format = 'PNG'
      img.to_blob
    end
  end

end