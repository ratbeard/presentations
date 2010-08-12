Dir['*'].grep(/^\d/).each do |file|
  name = file[/(\d+-[^.]+)/, 1]
  contents = File.read(file)
  slides = contents.split(/^\-----+\d?\s*$/)
  
  slides.each_with_index {|txt, i|
    txt.strip!
    if txt[-1,1] == '/'
      index = txt.chomp('/').rindex('/') 
      txt = txt[0, index]
    end
    File.open("slides/#{name}-#{i}.rb", 'w') {|f| f.puts txt }
  }
  # break
end
