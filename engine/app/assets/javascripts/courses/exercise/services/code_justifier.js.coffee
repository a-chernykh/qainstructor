angular.module('exercise').factory 'codeJustifier', ->
  justify: (code, justifier) ->
    lines = code.split("\n")
    for num in [1..lines.length]
      lines[num] = justifier + lines[num] if lines[num]
    lines.join("\n")
