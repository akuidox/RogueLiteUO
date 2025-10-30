# Projectile Scene Setup

## Creating projectile.tscn

The mage ranged attack system needs a projectile scene. Here's how to create it:

### 1. Create New Scene
1. In Godot, click Scene → New Scene
2. Select **Area2D** as root node
3. Rename to "Projectile"
4. Attach script: `Projectile.gd`

### 2. Add Child Nodes

**Add a Sprite2D:**
- Name: `Sprite2D`
- In Inspector, set Texture to a simple colored rectangle (or icon.svg for testing)
- Set Scale to (0.3, 0.3) for smaller projectile
- Set Modulate to bright color (e.g., cyan for mage projectiles)

**Add a CollisionShape2D:**
- Name: `CollisionShape2D`
- In Inspector, Shape → New CircleShape2D
- Set radius to ~8-10 pixels

### 3. Configure Area2D Properties

Select the root **Projectile (Area2D)** node:
- Collision Layer: Enable Layer 3 (projectiles)
- Collision Mask: Enable Layer 1 (enemies) and Layer 2 (players)
- Monitoring: ON
- Monitorable: ON

### 4. Save the Scene

- Save as: `res://projectile.tscn`
- Make sure the filename is exactly "projectile.tscn" (lowercase)

## Testing

1. Open `player.tscn`
2. Change the `archetype` variable from "warrior" to "mage" in Inspector
3. Run the game (F5)
4. Left-click to shoot projectiles toward mouse cursor
5. Projectiles should:
   - Travel in straight line
   - Disappear after 600 pixels
   - Damage enemies on contact
   - Knockback enemies

## Troubleshooting

**Error: "res://projectile.tscn does not exist"**
- Make sure you saved the scene with exact name "projectile.tscn"

**Projectiles don't hit enemies:**
- Check collision layers (projectile Layer 3, enemies Layer 1)
- Verify CollisionShape2D has a shape assigned

**Projectiles invisible:**
- Add Sprite2D child with a texture or color
- Check Sprite2D visibility is ON

## Co-op Consideration

The `owner_group` parameter ensures:
- Player projectiles ignore player
- Enemy projectiles (future) ignore enemies
- Perfect for multiplayer - each player's projectiles won't hit their teammate
