def colors(filename)
  file = File.new('backgrounds/.' + filename + '.Xres', 'r')
  html = "<div style='float:left; display:inline;'>"
  while (line = file.gets)
    color = /#[0-9a-f]{6}/.match(line)
    html += "<div height=100px style='background:#{color}'>#{color}</div>"
  end
  html += '</div>'
  return html
end

def thumbnails(images)
  html = ''
  for image in images
    html += "<div style='clear:both;'>"
      html += "<img src='backgrounds/#{image}' height=400px style='float:left; display:inline;>'\n"
      html += colors(image)
    html += "</div>"
  end
  return html
end

images = Dir.entries('backgrounds').select {|file| /^[^\.]/.match(file) }

# write html to index.html
File.open("index.html", "w") do |f|
  f.write thumbnails(images)
end
