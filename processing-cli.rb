require 'fileutils'
# sketch_150204a

ALPHABET = *('a'..'z').to_a

now = Time.now

sketch_name_base = 'sketch_' +
                   (now.year - 2000).to_s.ljust(2,'0') +
                   now.mon.to_s.ljust(2, '0') +
                   now.mday.to_s.ljust(2, '0')

sketches_from_today = Dir.glob("#{sketch_name_base}[a-z]")

# Print the sketches that already exist
sketches_from_today.each { |sketch| puts " --- #{sketch}"}

letter_suffix = ALPHABET[sketches_from_today.count]

sketch_name = sketch_name_base + letter_suffix
sketch_file = "#{sketch_name}/#{sketch_name}.pde"

FileUtils.mkdir sketch_name
FileUtils.touch sketch_file

puts " -*- #{sketch_name}"

%x['/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl' #{sketch_file}]
