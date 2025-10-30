# TODO - RogueLiteUO Development

## 🎯 FRIEND PLAYTEST SPRINT (THIS WEEK)
**Goal:** Make game playable for friends by end of week

### Priority 1: Make All Archetypes Playable ⚠️ CRITICAL (2-3 hrs)
- [ ] Implement mage ranged projectile attack (shoots toward mouse, 600px range)
- [ ] Implement support area heal ability (heals player, damages nearby enemies)
- [ ] Test all three archetypes are fun and balanced

### Priority 2: Skill Display UI (1-2 hrs)
- [ ] Create top-left UI panel showing current skills
- [ ] Color-code highest skill (green)
- [ ] Show archetype name
- [ ] Test UI visibility and readability

### Priority 3: Enemy Variety (2-3 hrs)
- [ ] Create Tank enemy (slow, high health, heavy damage)
- [ ] Create Ranger enemy (medium speed, shoots projectiles)
- [ ] Update dungeon to spawn mixed enemy types
- [ ] Test different enemy combinations

### Priority 4: Victory/Death Screen (1 hr)
- [ ] Create victory screen with stats (time, kills, damage)
- [ ] Create death screen with stats
- [ ] Add "Press E to continue" or auto-return after 3s
- [ ] Test both screens display correctly

### Bonus Features (If Time Permits)
- [ ] Floating damage numbers above enemies
- [ ] "Press E to Enter" prompt at portals
- [ ] Background music (hub + dungeon tracks)

## Current Work In Progress
- Setting up friend playtest sprint

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

## Post-Playtest Features (After Friends Test)

### Core Gameplay
- [ ] Add more dungeon layouts for each difficulty level
- [ ] Add particle effects for combat
- [ ] Add attack animations
- [ ] More enemy types and behaviors

### Progression System
- [ ] Add loot/reward system after clearing dungeons
- [ ] Implement permanent upgrades/unlocks
- [ ] Add currency/resource system
- [ ] Save player progress between sessions

### Polish
- [ ] Add sound effect audio files (code hooks ready, see AUDIO_SETUP.md)
- [ ] More UI improvements (minimap, enemy health bars, etc.)
- [ ] Visual effects and polish

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
