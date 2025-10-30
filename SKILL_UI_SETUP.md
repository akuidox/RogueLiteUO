# Skill Display UI Setup

## Overview
Shows player's current archetype and skills in top-left corner during dungeon runs. This helps players understand their randomized build each run.

## Setup in test_dungeon.tscn

### 1. Add SkillDisplayUI Node

1. Open `test_dungeon.tscn` in Godot
2. Add a new child **Node** to the root (Test Dungeon)
3. Name it: `SkillDisplayUI`
4. Attach script: `SkillDisplayUI.gd`

**That's it!** The script auto-creates all UI elements programmatically.

### 2. Test the UI

1. Run the game (F5)
2. Select an archetype in hub
3. Enter a portal
4. You should see in top-left:

```
┌─────────────────┐
│ WARRIOR         │
│ ───────────────│
│ Combat: 73      │ (Green = highest)
│ Magic: 12       │
│ Support: 5      │
│ ───────────────│
│ HP: 150 / 150   │
└─────────────────┘
```

### 3. What You'll See

**Archetype Name:**
- Large bold text (20px font)
- Shows WARRIOR, MAGE, or SUPPORT

**Skills:**
- Shows exact values (randomized each run)
- **Highest skill is GREEN** - shows your "build" at a glance
- Other skills are white
- Updates in real-time (but shouldn't change during dungeon)

**Health:**
- Shows current/max HP
- Color-coded:
  - Green (>60% HP)
  - Yellow (30-60% HP)
  - Red (<30% HP)
- Updates every frame

## Customization

### Change Position

Edit `SkillDisplayUI.gd` line 19:
```gdscript
panel.position = Vector2(10, 10)  # Top-left corner
```

Try:
- Top-right: `Vector2(1720, 10)`
- Bottom-left: `Vector2(10, 930)`

### Change Size

Edit line 20:
```gdscript
panel.size = Vector2(200, 150)
```

### Hide Specific Stats

Comment out sections in `create_ui()`:
```gdscript
# Don't show support skill
# support_label = Label.new()
# vbox.add_child(support_label)
```

## Why This Matters for Playtest

**Before UI:**
- Player: "Why does this run feel different?"
- No idea what their randomized stats are

**After UI:**
- Player: "Oh, I got high magic this time! Last run was high combat!"
- Understands build variety
- Can strategize based on visible stats
- Creates "Oh I want to try a high magic run again" moments

## Technical Notes

- Uses `CanvasLayer` so UI renders on top of game
- Finds player via "player" group
- Updates every frame in `_process()`
- Auto-creates all UI elements (no manual scene setup needed)
- Lightweight (just label updates)

## Co-op Consideration

For multiplayer:
- Each player needs their own SkillDisplayUI
- Attach to player's camera instead of dungeon scene
- Or create split-screen UI layout showing all players' stats
