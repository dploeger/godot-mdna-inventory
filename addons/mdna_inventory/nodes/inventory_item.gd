# The inventory item
class_name InventoryItem
extends TextureButton


# Emitted, when a hotspot was triggered
signal triggered_hotspot

# Emitted, when another inventory item was triggered
signal triggered_inventory_item

# The title of the inventory item
var title: String
# A description for the inventory item
var description: String
# The image/mouse pointer for the inventory item
var image_normal: Texture
# The image/mouse pointer for the inventory item if it's selected
var image_active: Texture
# A list of hotspots this inventory item should react to
var trigger_hotspots: Array

# Wether we're on touch devices
onready var _is_touch: bool = OS.has_touchscreen_ui_hint()


# Handle touch/press inputs on hotspots
func _input(event):
	var position: Vector2
	var action: bool
	if event is InputEventMouseButton \
			and (event as InputEventMouseButton).button_index == BUTTON_LEFT:
		position = get_viewport().get_mouse_position()
		action = true
	elif event is InputEventScreenTouch \
			and (event as InputEventScreenTouch).pressed:
		position = (event as InputEventScreenTouch).position
		action = true
	
	if action:
		var trigger_hotspot = _is_over_hotspot(position)
		if trigger_hotspot != null:
			emit_signal("triggered_hotspot", trigger_hotspot, self)


# Handle mouse cursor changes when the item is over a hotspot
func _process(delta):
	if ! _is_touch and MdnaInventory.selected_item == self:
		var trigger_hotspot = _is_over_hotspot(
			get_viewport().get_mouse_position()
		)
		if trigger_hotspot == null:
			Input.set_custom_mouse_cursor(image_normal)
		else:
			Input.set_custom_mouse_cursor(image_active)


# Convenience method to set the images
#
# **Arguments**
# 
# - p_image_normal: The texture to use for the image and mousepointer
# - p_image_active: The texture to use for the image and mousepointer when the
#   item was selected
func set_images(p_image_normal: Texture, p_image_active: Texture):
	image_active = p_image_active
	image_normal = p_image_normal
	texture_normal = image_normal


# Convenience method to add a hotspot
#
# **Arguments**
# - name: Then name of the hotspot
# - scene_name: The scene name where this hotspot should be active
# - upper_left: The upper left vector of the hotspot
# - lower_right: The lower right vector of the hotspot
func add_hotspot(
	name: String, 
	scene_name: String, 
	upper_left: Vector2, 
	lower_right: Vector2
):
	var hotspot = TriggerHotspot.new()
	hotspot.name = name
	hotspot.scene_name = scene_name
	hotspot.upper_left = upper_left
	hotspot.lower_right = lower_right
	trigger_hotspots.append(hotspot)


# Handle clicks on another inventory item
func _on_InventoryItem_pressed():
	if MdnaInventory.selected_item == self:
		# On touch, selecting the same item again, deselects it
		MdnaInventory.selected_item = null
		texture_normal = image_normal
	elif MdnaInventory.selected_item != null:
		# Another item was triggered with the current one
		emit_signal(
			"triggered_inventory_item", 
			MdnaInventory.selected_item, 
			self
		)
	else:
		# Select this inventory item
		texture_normal = null
		MdnaInventory.selected_item = self
		if _is_touch:
			texture_normal = image_active
		else:
			Input.set_custom_mouse_cursor(image_normal)


# A helper function that looks through the list of hotspots wether the 
# hotspot is valid for the current scene and the specified position is
# inside the hotspot
#
# **Arguments**
#
# - position: The position to check against all valid hotspots
func _is_over_hotspot(position: Vector2) -> TriggerHotspot:
	if position.y <= MdnaInventory.get_node("Canvas/Panel").rect_size.y:
		# Positions over the inventory area aren't checked per default
		return null
	for hotspot in trigger_hotspots:
		if (hotspot as TriggerHotspot).is_over(get_tree() \
				.current_scene.filename, position):
			return hotspot
	return null
