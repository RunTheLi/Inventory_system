🎒 Godot Inventory System (Godot 4)

A modular inventory system built in Godot 4 featuring item data, grid-based UI, drag & drop, world pickups, and item usage.
Designed with clean architecture and scalability in mind.

✨ Features

Global inventory data (30 slots)

Stackable items

Grid-based inventory UI

Item icons + quantity display

Left-click to use items

Right-click to drop items

Drag & drop to swap inventory slots

Items can be dropped into the world

World items can be picked up by the player

🧠 Architecture Overview
Component	Responsibility
Global.gd	Inventory data & logic
Item.gd	Item definition (id, name, icon, quantity, effects)
InventoryUI.gd	Inventory UI logic
SlotButton.gd	Inventory slot behavior (drag & drop)
PickupItem.gd	World item pickup logic
Player	Movement & interaction

Each script has one clear responsibility, following good game architecture practices.

📂 Project Structure
res://
├── Assets/
│   └── Icons/
├── Scenes/
│   ├── Player.tscn
│   ├── PickupItem.tscn
│   └── InventoryUI.tscn
├── Scripts/
│   ├── Global.gd
│   ├── Item.gd
│   ├── SlotButton.gd
│   ├── PickupItem.gd
│   └── InventoryUI.gd

📦 Inventory Data (Global.gd)

Inventory size: 30 slots

Stored as an array

Emits inventory_updated signal on changes

Handles:

Adding items

Removing items

Swapping slots

Dropping items into the world

🧱 Item System (Item.gd)

Each item contains:

id

name

icon

quantity

stackable

max_stack

Items can define a custom use(player) function for effects (e.g. healing).

🖱 Inventory UI

Built with CanvasLayer

Uses a GridContainer

Rebuilds dynamically when inventory changes

Each slot displays:

Item icon

Quantity text

Controls
Input	Action
Left Click	Use item
Right Click	Drop item
Drag	Swap items
🔄 Drag & Drop System

Implemented via a custom SlotButton class

Uses Godot’s Control drag & drop API

Slots can exchange items by dragging between them

No hard-coded UI references

🌍 World Pickup System
PickupItem Scene

Area2D

Sprite2D

CollisionShape2D

Behavior

Spawns when an item is dropped

Displays the item icon

Adds item to inventory when player enters

Automatically removes itself after pickup

🧍 Player Setup

Player node must be in the player group

Uses simple movement logic

Interacts with pickup items via collision

🔁 Full Gameplay Loop
Inventory
   ↓
Drop Item
   ↓
World Pickup Appears
   ↓
Player Walks Over Item
   ↓
Item Added Back to Inventory

🚀 Future Improvements

Stack splitting (Shift + drag)

Equipment slots (weapon / armor)

Save & load inventory

Tooltips & item descriptions

Pickup animations & sounds

🧩 Built With

Godot 4

GDScript
