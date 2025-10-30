# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**RogueLiteUO** is a Godot 4.5 rogue-lite game with Ultima Online-inspired mechanics. The game features a hub world where players select portals to enter procedurally-modified dungeons with different difficulty levels.

## Running the Game

This is a Godot project. To run:
- Open the project in Godot 4.5 or later
- Main scene: `res://hub.tscn`
- Press F5 in Godot editor to run the game

The project uses 1920x1080 viewport with viewport stretching mode.

## Core Architecture

### Game Flow
1. **Hub (hub.tscn)**: Starting area with 3 portals (Easy/Challenging/Hard)
2. **Portal Interaction**: Player presses 'E' near portal → Skills randomized → Dungeon loaded
3. **Dungeon (test_dungeon.tscn)**: Combat arena with enemies
4. **Victory/Death**: Returns to hub after all enemies killed or player dies

### Key Systems

**Portal System (Portal.gd)**
- Manages dungeon entry and difficulty selection
- Randomizes player skills before entering dungeon (based on archetype constraints)
- Three difficulty levels with color coding: Easy (blue), Challenging (yellow), Hard (red)
- Currently all difficulties load `test_dungeon.tscn` - expand `dungeon_scenes` dictionary to add more dungeons

**Dungeon Manager (DungeonManager.gd)**
- Tracks enemy count and victory conditions
- Must be in "dungeon_manager" group in scene tree
- Automatically returns to hub when all enemies defeated
- Enemies must be in "enemy" group to be counted

**Player System (PlayerController.gd)**
- Three archetypes with distinct attack styles:
  - **Warrior**: Melee combat (200px range, combat skill scales damage)
  - **Mage**: Ranged projectiles (600px range, magic skill scales damage)
  - **Support**: Extended melee (250px range, designed for co-op healing - TODO)
- Skills dictionary: combat, magic, support, health
- Must be in "player" group for detection
- Skills get randomized when entering portal (within archetype limits)
- Attack cooldown: 0.4 seconds with visual feedback (sprite pulse, camera shake)
- Movement speed: 300 pixels/second

**Projectile System (Projectile.gd)**
- Reusable for player mage attacks and enemy ranger attacks (future)
- Configurable: speed (400px/s), damage, max distance (600px)
- `owner_group` parameter prevents hitting teammates (co-op ready)
- Auto-cleanup on collision or max distance
- See PROJECTILE_SETUP.md for scene creation

**Enemy AI (Enemy.gd)**
- Detection range: 400 pixels (starts chasing player)
- Attack range: 160 pixels (stops and attacks)
- Attack cooldown: 1 second
- Must be in "enemy" group for DungeonManager tracking
- Notifies DungeonManager on death

**Health System (HealthBar.gd)**
- Auto-attached to entities with `max_health` and `current_health` properties
- Updates every frame by reading parent's current_health

**Combat Feedback System**
- **Hit Effects (Enemy.gd)**: Knockback, red flash animation, brief hit-stop (0.03s freeze frame)
- **Camera Shake (CameraShake.gd)**: Light shake on enemy hit, stronger on player damage
- **Audio Hooks**: Ready for AttackSound, HitSound (nodes need manual setup - see AUDIO_SETUP.md)
- **Visual Feedback**: Sprite pulse on attack, damage numbers (TODO)

## Input Actions

Defined in project.godot:
- `move_left` (A), `move_right` (D), `move_up` (W), `move_down` (S)
- `attack` (Left Mouse Button)
- `interact` (E) - Used for portal entry

## Scene Structure

**player.tscn**: CharacterBody2D with PlayerController.gd, sprite, camera (needs CameraShake node + audio nodes)
**enemy.tscn**: CharacterBody2D with Enemy.gd, sprite, health bar (needs HitSound audio node)
**projectile.tscn**: Area2D with Projectile.gd for ranged attacks (needs manual creation - see PROJECTILE_SETUP.md)
**portal.tscn**: Area2D with Portal.gd, difficulty detection zones
**hub.tscn**: Hub world with player spawn and 3 portals
**test_dungeon.tscn**: Combat arena with DungeonManager node and enemy spawns

## Code Conventions

- Scripts are in French comments (legacy codebase)
- Use Godot groups for entity detection: "player", "enemy", "dungeon_manager"
- Scene transitions use `get_tree().change_scene_to_file()`
- Export variables (@export) for designer-tunable parameters
- Entity communication via `has_method()` checks for loose coupling
