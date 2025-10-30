# Audio Setup Guide

## Overview
This guide explains how to add audio feedback to your game. The code is ready to play sounds, you just need to add the AudioStreamPlayer nodes in Godot.

## Player Audio (player.tscn)

Open `player.tscn` in Godot and add these child nodes to the root Player node:

1. **AttackSound** (AudioStreamPlayer)
   - Add as child of Player (CharacterBody2D)
   - Name: `AttackSound`
   - Will play when player attacks

2. **HitSound** (AudioStreamPlayer)
   - Add as child of Player (CharacterBody2D)
   - Name: `HitSound`
   - Will play when player takes damage

## Enemy Audio (enemy.tscn)

Open `enemy.tscn` in Godot and add this child node to the root Enemy node:

1. **HitSound** (AudioStreamPlayer)
   - Add as child of Enemy (CharacterBody2D)
   - Name: `HitSound`
   - Will play when enemy takes damage

## Camera Shake Setup (player.tscn)

The camera shake system also needs manual setup:

1. Select the **Camera2D** node under Player
2. Add a child **Node** (not Node2D, just Node)
3. Name it: `CameraShake`
4. Attach script: `CameraShake.gd`

## Adding Sounds (Later)

For now, the AudioStreamPlayer nodes can remain empty. When you're ready to add sounds:

1. Import audio files (.wav, .ogg, .mp3) into Godot
2. Select each AudioStreamPlayer node
3. In Inspector, drag audio file to "Stream" property
4. Adjust volume/pitch as needed

## Testing Without Sounds

The game will work fine without audio files assigned - it just won't play sounds yet. The code safely checks if nodes exist before trying to play them.

## Placeholder Sounds

You can use simple beep sounds or free sound effects from:
- https://freesound.org/
- https://opengameart.org/
- Godot's built-in AudioStreamGenerator for procedural beeps
