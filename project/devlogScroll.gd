extends ScrollContainer
var max_scroll_length = 0 
@onready var scrollbar = get_v_scroll_bar()

func _ready():
	# TODO This doesn't work for HTML5, but I don't know why
	# Actually i don't know why it works on mac
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
		self.scroll_vertical = max_scroll_length
