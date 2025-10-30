# Archetype Selection Setup

## Overview
Players need to be able to choose their archetype (Warrior/Mage/Support) in the hub before entering portals.

## Setup in hub.tscn

### 1. Create Warrior Selector

1. Open `hub.tscn` in Godot
2. Add a new child **Area2D** node to the root Hub node
3. Name it: `WarriorSelector`
4. Attach script: `ArchetypeSelector.gd`
5. In Inspector, set:
   - `Archetype`: warrior
   - `Display Name`: WARRIOR

**Add CollisionShape2D:**
- Add child **CollisionShape2D** to WarriorSelector
- Shape → New RectangleShape2D
- Size: ~100x100 pixels
- This is the interactive zone

**Add Label:**
- Add child **Label** to WarriorSelector
- Text: "WARRIOR"
- Adjust font size/position so it's readable
- This shows the archetype name

**Position:**
- Place left of the portals (e.g., position -400, 0)
- Make sure collision shape covers the area where player stands

### 2. Create Mage Selector

Duplicate WarriorSelector:
1. Right-click WarriorSelector → Duplicate
2. Rename to: `MageSelector`
3. Position: Middle-left (e.g., -400, 150)
4. In Inspector, set:
   - `Archetype`: mage
   - `Display Name`: MAGE
5. Update Label text to "MAGE"

### 3. Create Support Selector

Duplicate again:
1. Right-click MageSelector → Duplicate
2. Rename to: `SupportSelector`
3. Position: Middle-left (e.g., -400, 300)
4. In Inspector, set:
   - `Archetype`: support
   - `Display Name`: SUPPORT
5. Update Label text to "SUPPORT"

## Visual Layout Suggestion

```
    [WARRIOR]
                    Portal 1 (Easy)
    [MAGE]
                    Portal 2 (Challenging)
    [SUPPORT]
                    Portal 3 (Hard)

     Player spawns here
```

## Testing

1. Run the game (F5)
2. Walk to each archetype selector zone
3. Label should change to "[E] SELECT WARRIOR" (yellow text)
4. Press E to select archetype
5. Label flashes green briefly
6. Enter a portal and test the archetype:
   - Warrior: Melee attacks
   - Mage: Ranged projectiles
   - Support: Extended melee

## Optional Enhancements

**Visual Feedback:**
- Add colored Sprite2D behind each label (red = warrior, blue = mage, green = support)
- Add icons representing each archetype

**Current Selection Display:**
- Add a persistent label showing "Current: WARRIOR" somewhere visible
- Update it when player selects new archetype

## How It Works

1. Player walks into ArchetypeSelector Area2D zone
2. Label changes to show "[E] SELECT [ARCHETYPE]"
3. Player presses E (interact)
4. Script calls `player.set_archetype(archetype)`
5. Player's archetype is updated
6. When entering portal, skills are randomized based on new archetype
7. Combat uses archetype-specific attack (melee/ranged/support)

## Co-op Note

When implementing multiplayer, each player should have their own archetype selection. The current implementation already supports this - just ensure each player instance calls `set_archetype()` independently.
