# Render this by running:
# victor render "logo.rb"

setup viewBox: "0 0 100 100", width: 600, height: 600

build do
  defs do
    mask id: :hole1 do
      rect width: 100, height: 100, fill: :white
      circle r: 30, cx: 50, cy: 50, fill: :black
      rect x: 47, width: 6, height: 100, fill: :black
    end

    mask id: :hole2 do
      rect width: 100, height: 100, fill: :white
      circle cx: 50, cy: 50, r: 10, fill: :black
      rect x: 47, y: 0, width: 6, height: 50, fill: :black
      rect width: 53, height: 100, fill: :black
    end
  end

  # rect x: 0, y: 0, width: 100, height: 100, fill: '#aaa'
  
  g id: :logo do
    circle cx: 50, cy: 50, r: 40, fill: '#333', mask: 'url(#hole1)'
    circle cx: 50, cy: 50, r: 20, fill: '#333', mask: 'url(#hole2)'
    rect x: 53, y: 20, width: 10, height: 30, fill: '#333', mask: 'url(#hole2)'
  end
end
