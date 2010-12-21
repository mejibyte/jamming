jamming
===

Jamming is a Ruby library to generate images of guitar chords.

Installation
---

    gem install jamming

or if you are using Bundler, add this line to your Gemfile:

    gem "jamming"
    
Usage
---

    File.open("/tmp/old_good_jimi.png", 'w') do |f|
       chord = Jamming::Chord.new("0-7-6-7-8-x")
       f.write chord.to_png(:label => "Em7#9")
    end
    
This will write Em7#9, <em>The Jimi Hendrix Chord</em>, to <tt>/tmp/old_good_jimi.png</tt>:

![Em7#9 - The Jimi Hendrix Chord](https://github.com/andmej/jamming/raw/master/examples/Em7%239.png)

### Auto labels

Jamming has an internal database with some chords that lets her auto-identify some chords. So, for example:

     File.open("/tmp/a_major.png", 'w') do |f|
         chord = Jamming::Chord.new("x-0-2-2-2-0")
         f.write chord.to_png
     end
     
will generate an image like this:

![A Major](http://jamming.heroku.com/chords/x02220)

(Notice the _A_ label even if you never explicitly declared it.)

If you'd like to override this behavior, pass `:label => nil` to the `to_png` method.

If you find a chord that is not auto-labeled but you'd like it to be, please add it [to this file](https://github.com/andmej/jamming/blob/master/lib/jamming/dictionary.rb) and send a pull request.

### Front-end

Jamming is better served with a front-end that takes care of generating the images for you. Check out [this tiny Sinatra app](https://github.com/andmej/jamming_frontend) that does just that.

Thanks
---

Some code based on [ander/chords](https://github.com/ander/chords), thanks!

Contributing to jamming
---
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---

Copyright (c) 2010 Andrés Mejía. See LICENSE.txt for
further details.

Other important notes
---

You suck if you don't play guitar, kthxbai.