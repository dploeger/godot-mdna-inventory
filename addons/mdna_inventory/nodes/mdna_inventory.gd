# The main inventory scene for the MDNA inventory plugin
extends Control

# Emitted when the notepad button was pressed
signal notepad_pressed

# Emitted when the menu button was pressed (on touch devices)
signal menu_pressed


# The currently selected inventory item or null
var selected_item: InventoryItem = null

# Wether the inventory is currently activated
var activated: bool = false

# The list of inventory items
var _inventory_items: Array

# The inventory configuration
var _configuration: InventoryConfiguration


# Helper variable if we're on a touch device
onready var is_touch: bool = OS.has_touchscreen_ui_hint()


# Hide the activate and menu button on touch devices
func _ready():
	if ! is_touch:
		$Activate.hide()
		$Canvas/Panel/InventoryPanel/Menu.hide()


# Handle inventory drop events and border trigger for mouse
func _input(event):
	# Drop the inventory item on RMB and two finger touch
	if event is InputEventMouseButton and \
		(event as InputEventMouseButton).button_index == BUTTON_RIGHT and \
		(event as InputEventMouseButton).pressed:
		selected_item.texture_normal = \
				(selected_item as InventoryItem).image_normal
		selected_item = null
	elif event is InputEventScreenTouch and \
		(event as InputEventScreenTouch).index == 2 and \
		(event as InputEventScreenTouch).pressed:
		selected_item.texture_normal = \
				(selected_item as InventoryItem).image_normal
		selected_item = null
	elif ! is_touch and event is InputEventMouse and $Timer.is_stopped():
		# Activate the inventory when reaching the upper screen border
		if ! activated and get_viewport().get_mouse_position().y <= 10:
			_toggle_inventory()
		# Deactivate the inventory when the mouse is below it
		elif activated and \
				get_viewport().get_mouse_position().y \
				> $Canvas/Panel.rect_size.y:
			_toggle_inventory()


# Set standard mouse cursor when no selected item is present
func _process(delta):
	if ! is_touch and selected_item == null:
		Input.set_custom_mouse_cursor(null)


# Configure the inventory. Should be call by a game core singleton
func configure(configuration: InventoryConfiguration):
	_configuration = configuration
	$Canvas/Panel/InventoryPanel/Menu.texture_normal = \
			_configuration.texture_menu
	$Canvas/Panel/InventoryPanel/Notepad.texture_normal = \
			_configuration.texture_notepad
	$Activate.texture_normal = _configuration.texture_activate
	$Canvas/Panel.theme = _configuration.theme
	$Canvas/Panel.margin_top = _configuration.size * -1
	$Canvas/Panel.rect_min_size.y = _configuration.size
	var animation: Animation = $Animations.get_animation("Activate")
	animation.track_set_key_value(0,0,Vector2(0, _configuration.size * -1))
	animation.track_set_key_value(1,1,_configuration.size)


# Disable the inventory system
func disable():
	$Canvas/Panel.hide()
	$Activate.hide()


# Enable the inventory system
func enable():
	$Canvas/Panel.show()
	if is_touch:
		$Activate.show()


# Add an item to the inventory
func add_item(item: InventoryItem):
	_inventory_items.append(item)
	_update()
	if ! activated:
		# Briefly show the inventory when it is not activated
		_toggle_inventory()
		$Timer.start()
		yield($Timer,"timeout")
		$Timer.stop()
		_toggle_inventory()


# Show or hide the inventory
func _toggle_inventory():
	if activated:
		$Animations.play_backwards("Activate")
		activated = false
	else:
		$Animations.play("Activate")
		activated = true


# Activate the inventory (on touch devices)
func _on_Activate_pressed():
	_toggle_inventory()


# Emit signal, that the notepad was pressed
func _on_Notepad_pressed():
	emit_signal("notepad_pressed")


# Emit signal, that the menu was pressed
func _on_Menu_pressed():
	emit_signal("menu_pressed")


# Update the inventory item view by simply removing all items and re-adding them
func _update():
	for child in $Canvas/Panel/InventoryPanel/Inventory.get_children():
		$Canvas/Panel/InventoryPanel/Inventory.remove_child(child)
	for item in _inventory_items:
		$Canvas/Panel/InventoryPanel/Inventory.add_child(item)
