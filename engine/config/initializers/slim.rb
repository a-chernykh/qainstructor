# required to pre-format code properly for ace editor
Slim::Engine.options[:pretty] = false

# so that curly braces can be used by angularjs
Slim::Engine.set_options :attr_list_delims => {'(' => ')', '[' => ']'}
