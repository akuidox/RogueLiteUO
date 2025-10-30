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
- Three archetypes: warrior (high combat), mage (high magic), support (balanced)
- Skills dictionary: combat, magic, support, health
- Attack range: 200 pixels
- Must be in "player" group for detection
- Skills get randomized when entering portal (within archetype limits)

**Enemy AI (Enemy.gd)**
- Detection range: 400 pixels (starts chasing player)
- Attack range: 160 pixels (stops and attacks)
- Attack cooldown: 1 second
- Must be in "enemy" group for DungeonManager tracking
- Notifies DungeonManager on death

**Health System (HealthBar.gd)**
- Auto-attached to entities with `max_health` and `current_health` properties
- Updates every frame by reading parent's current_health

## Input Actions

Defined in project.godot:
- `move_left` (A), `move_right` (D), `move_up` (W), `move_down` (S)
- `attack` (Left Mouse Button)
- `interact` (E) - Used for portal entry

## Scene Structure

**player.tscn**: CharacterBody2D with PlayerController.gd, sprite, camera
**enemy.tscn**: CharacterBody2D with Enemy.gd, sprite, health bar
**portal.tscn**: Area2D with Portal.gd, difficulty detection zones
**hub.tscn**: Hub world with player spawn and 3 portals
**test_dungeon.tscn**: Combat arena with DungeonManager node and enemy spawns

## Code Conventions

- Scripts are in French comments (legacy codebase)
- Use Godot groups for entity detection: "player", "enemy", "dungeon_manager"
- Scene transitions use `get_tree().change_scene_to_file()`
- Export variables (@export) for designer-tunable parameters
- Entity communication via `has_method()` checks for loose coupling
