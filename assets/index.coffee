
wordWrap = (ctx, text) ->
  W = 400

  line = ''
  lines = []
  for c in text
    if ctx.measureText(line + c).width > W
      if c is ' '
        lines.push line
        line = ''
      else
        idx = line.lastIndexOf ' '
        lines.push line.substring 0, idx
        line = line.substring(idx + 1) + c
    else
      line += c
  if line.length > 0
    lines.push line

  return lines


class Editor
  constructor: (@el) ->
    @canvas = document.createElement 'canvas'
    @el.appendChild @canvas
    @canvas.height = 300
    @canvas.width = 400
    @blocks = [
      type: 'h1'
      text: 'Hej'
    ,
      type: 'p'
      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    ]
    @draw()
  draw: ->
    ctx = @canvas.getContext '2d'

    y = 0
    ctx.textBaseline = 'top'

    for block in @blocks

      h = switch block.type
        when 'h1' then 28
        when 'h2' then 24
        when 'h3' then 18
        when 'h4' then 16
        when 'h5' then 14
        when 'h6' then 13
        when 'p' then 12
      ctx.font = h + 'px sans-serif'

      lines = wordWrap ctx, block.text
      for line in lines
        ctx.fillText line, 0, y
        y += h + 2
      y += 12


window.mdeditor = (element) ->
  new Editor element
