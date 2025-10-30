# TODO - RogueLiteUO Development

## Current Work In Progress
<!-- Update this section when you start working on something -->
- None currently

## ⚠️ Manual Setup Required
**Combat feedback system is implemented but needs scene setup:**
- Add `CameraShake` Node to Camera2D in player.tscn (attach CameraShake.gd)
- Add `AttackSound` and `HitSound` AudioStreamPlayer nodes to player.tscn
- Add `HitSound` AudioStreamPlayer node to enemy.tscn
- See `AUDIO_SETUP.md` for detailed instructions

## Recently Completed
- [x] Increase player movement speed (200 → 300)
- [x] Add attack cooldown system (0.4s between attacks)
- [x] Add visual feedback for attacks (sprite pulse)
- [x] Add enemy hit effects (knockback, flash, hit-stop)
- [x] Add camera shake system
- [x] Add audio hooks (ready for sound files)

## Next Steps / Planned Features

### Core Gameplay
- [ ] Add more dungeon layouts for each difficulty level
- [ ] Implement magic attacks for mage archetype
- [ ] Implement support abilities for support archetype
- [ ] Add particle effects for combat
- [ ] Add attack animations
- [ ] Implement enemy variety (different types)

### Progression System
- [ ] Add loot/reward system after clearing dungeons
- [ ] Implement permanent upgrades/unlocks
- [ ] Add currency/resource system
- [ ] Save player progress between sessions

### Polish
- [ ] Add sound effect audio files (code hooks ready, see AUDIO_SETUP.md)
- [ ] Add background music
- [ ] Improve UI (health bars, dungeon info)
- [ ] Add death/victory screen with stats

### Level Design
- [ ] Create distinct dungeon environments
- [ ] Add obstacles and dungeon hazards
- [ ] Implement procedural dungeon generation

## Known Issues
<!-- Document bugs or problems here -->
- None currently

## Ideas / Backlog
- Boss encounters for hard difficulty
- Equipment/inventory system
- Co-op multiplayer
- Achievement system
