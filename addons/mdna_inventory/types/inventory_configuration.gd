# The configuration resource of the mdna inventory system
tool
class_name InventoryConfiguration
extends Resource


# The vertical size of the inventory
var size: int = 92

# The theme to use for the inventory panel
var theme: Theme

# The texture for the menu button (on touch devices)
var texture_menu: Texture

# The texture for the notepad button
var texture_notepad: Texture

# The texture for the inventory activate button (on touch devices)
var texture_activate: Texture


# Build the property list of the resource
func _get_property_list():
	var properties = []
	properties.append({
		"name": "size",
		"type": TYPE_INT
	})
	properties.append({
		"name": "theme",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Theme"
	})
	properties.append({
		"name": "texture_menu",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Texture"
	})
	properties.append({
		"name": "texture_notepad",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Texture"
	})
	properties.append({
		"name": "texture_activate",
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Texture"
	})
	return properties
