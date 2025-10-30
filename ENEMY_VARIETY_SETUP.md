# Enemy Variety Setup

## Overview
Create three distinct enemy types with different behaviors, stats, and visual appearance:
- **Chaser** (current enemy): Fast melee
- **Tank**: Slow, high HP, heavy damage
- **Ranger**: Fast, low HP, ranged projectile attacks

## Creating Enemy Variants in Godot

### 1. Chaser Enemy (Already Exists)
The current `enemy.tscn` is the Chaser type. We'll keep it as-is.

**Default Stats:**
- Enemy Type: chaser
- Max Health: 50
- Speed: 150
- Attack Damage: 10
- Attack Range: 160
- Detection Range: 400

### 2. Create Tank Enemy

1. **Duplicate enemy.tscn**:
   - Right-click `enemy.tscn` in FileSystem
   - Duplicate
   - Rename to: `enemy_tank.tscn`

2. **Update Tank Stats** (in Inspector):
   - Open `enemy_tank.tscn`
   - Select root Enemy node
   - In Inspector, set:
     - **Enemy Type**: tank
     - **Max Health**: 100 (double HP!)
     - **Speed**: 100 (slower than chaser)
     - **Attack Damage**: 15 (hits harder)
     - **Attack Range**: 160 (same)
     - **Detection Range**: 400 (same)

3. **Visual Distinction**:
   - Select Sprite2D child
   - In Inspector → Modulate: Set to RED tint (e.g., R:1.0, G:0.5, B:0.5)
   - Optional: Scale sprite larger (Scale: 1.5, 1.5)

4. **Save** enemy_tank.tscn

### 3. Create Ranger Enemy

1. **Duplicate enemy.tscn**:
   - Right-click `enemy.tscn`
   - Duplicate
   - Rename to: `enemy_ranger.tscn`

2. **Update Ranger Stats** (in Inspector):
   - Open `enemy_ranger.tscn`
   - Select root Enemy node
   - In Inspector, set:
     - **Enemy Type**: ranger
     - **Max Health**: 30 (fragile!)
     - **Speed**: 180 (fastest enemy)
     - **Attack Damage**: 8 (projectile damage)
     - **Attack Range**: 500 (long range - shoots from distance)
     - **Detection Range**: 500 (same as attack range)

3. **Visual Distinction**:
   - Select Sprite2D child
   - In Inspector → Modulate: Set to BLUE tint (e.g., R:0.5, G:0.7, B:1.0)
   - Optional: Scale sprite smaller (Scale: 0.8, 0.8)

4. **Save** enemy_ranger.tscn

## Update Dungeon Spawns

### test_dungeon.tscn

1. **Open test_dungeon.tscn**

2. **Current Setup** (3 enemies - all chasers):
   - Enemy
   - Enemy2
   - Enemy3

3. **New Setup** (5 mixed enemies):

   Keep existing:
   - Enemy → stays as chaser
   - Enemy2 → stays as chaser

   **Change Enemy3 to Tank:**
   - Select Enemy3
   - In Inspector → Scene → Change scene to `enemy_tank.tscn`
   - Reposition if needed

   **Add 2 New Enemies:**
   - Add → Instance Child Scene → `enemy_tank.tscn`
   - Name it: Enemy4 (Tank)
   - Position: Somewhere strategic

   - Add → Instance Child Scene → `enemy_ranger.tscn`
   - Name it: Enemy5 (Ranger)
   - Position: Back of arena (so it can shoot from distance)

4. **Suggested Layout**:
```
        [Ranger]  (back)

[Chaser]     [Tank]     [Chaser]

             [Tank]

      (Player spawns here)
```

5. **Save** test_dungeon.tscn

## Testing Enemy Behavior

### Chaser (Fast Melee)
- Runs at player quickly
- Stops at 160px to attack
- 50 HP - dies in ~5 warrior hits

### Tank (Slow Tank)
- Moves slowly toward player
- Takes lots of hits (100 HP)
- Hits very hard (15 damage) - scary up close!
- Strategy: Kite while killing others

### Ranger (Ranged Shooter)
- Stays 500px away
- Shoots blue projectiles at player
- Dies quickly (30 HP) - priority target!
- Forces player to move/dodge
- Strategy: Kill first or take constant damage

## Tactical Depth

With 5 mixed enemies, players must:
1. **Prioritize**: Kill ranger first (shoots constantly)
2. **Kite**: Don't let tank corner you
3. **Position**: Dodge ranger projectiles while fighting chasers
4. **Archetype Strategy**:
   - Warrior: Rush ranger, tank the tank
   - Mage: Stay back, pick off ranger/chasers, kite tank
   - Support: Extended range helps vs all types

## Color Coding Summary
- **Chaser**: White/Default (current enemy color)
- **Tank**: Red tint (danger, high HP)
- **Ranger**: Blue tint (ranged, priority target)

## Co-op Note
Mixed enemy types create natural roles:
- One player tanks the tank
- Other player kills ranger
- Both handle chasers together
