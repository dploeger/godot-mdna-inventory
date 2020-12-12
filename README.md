# MDNA Inventory

## Introduction

This is an inventory system used in MDNA games.

It's completely stylable and can hold inventory items which can be dropped on 
hotspots in certain scenes as well on other inventory items.

It supports mouse as well as touch devices.

## Usage

Create an InventoryConfiguration resource and configure the inventory to
match your game style.

Then, from an initial screen, run MdnaInventory.configure() with the configuration
resource.

After that, it's available on every screen.

To disable it, use MdnaInventory.disable() and afterwards .enable() again.

## API-Docs

See the generated documentation for details:

* [InventoryConfiguration](docs/InventoryConfiguration.md)
* [InventoryItem](docs/InventoryItem.md)
* [TriggerHotspot](docs/TriggerHotspot.md)
