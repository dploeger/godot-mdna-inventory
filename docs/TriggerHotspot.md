<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# TriggerHotspot

**Extends:** [Resource](../Resource)

## Description

A trigger hotspot definition resource

## Property Descriptions

### name

```gdscript
var name: String
```

The name of the hotspot

### scene\_name

```gdscript
var scene_name: String
```

The name of the scene where this hotspot is valid

### upper\_left

```gdscript
var upper_left: Vector2
```

The upper left corner of the hotspot position

### lower\_right

```gdscript
var lower_right: Vector2
```

The lower right corner of the hotspot position

## Method Descriptions

### is\_over

```gdscript
func is_over(current_scene: String, position: Vector2) -> bool
```

A helper method to validate if the specified position is inside the hotspot

**Arguments**

- current_scene: The name of the current scene
- position: The position in question