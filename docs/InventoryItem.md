<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# InventoryItem

**Extends:** [TextureButton](../TextureButton)

## Description

The inventory item

## Property Descriptions

### title

```gdscript
var title: String
```

The title of the inventory item

### description

```gdscript
var description: String
```

A description for the inventory item

### image\_normal

```gdscript
var image_normal: Texture
```

The image/mouse pointer for the inventory item

### image\_active

```gdscript
var image_active: Texture
```

The image/mouse pointer for the inventory item if it's selected

### trigger\_hotspots

```gdscript
var trigger_hotspots: Array
```

A list of hotspots this inventory item should react to

## Method Descriptions

### set\_images

```gdscript
func set_images(p_image_normal: Texture, p_image_active: Texture)
```

Convenience method to set the images

**Arguments**

- p_image_normal: The texture to use for the image and mousepointer
- p_image_active: The texture to use for the image and mousepointer when the
  item was selected

### add\_hotspot

```gdscript
func add_hotspot(name: String, scene_name: String, upper_left: Vector2, lower_right: Vector2)
```

## Signals

- signal triggered_hotspot(): Emitted, when a hotspot was triggered
- signal triggered_inventory_item(): Emitted, when another inventory item was triggered
