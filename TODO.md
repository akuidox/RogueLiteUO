# TODO - RogueLiteUO Development

## 🎯 CURRENT STATUS - Ready for Manual Setup!

**Code Implementation:** ✅ COMPLETE
**Manual Setup in Godot:** ⚠️ REQUIRED (see below)
**Friend Playtest:** Ready after setup (15-20 min)

---

## ⚠️ MANUAL SETUP REQUIRED (Do These in Godot)

### Critical (Game Won't Work Without):
1. **Create projectile.tscn** (5 min) → See `PROJECTILE_SETUP.md`
   - Needed for Mage ranged attacks and Ranger enemies
   - Without this: Mage/Ranger won't attack but won't crash

2. **Add Archetype Selectors to hub.tscn** (5 min) → See `ARCHETYPE_SETUP.md`
   - 3 Area2D zones (Warrior/Mage/Support)
   - Without this: Stuck as warrior only

### Important (Game Works, But Missing Features):
3. **Add SkillDisplayUI to test_dungeon.tscn** (1 min) → See `SKILL_UI_SETUP.md`
   - Shows "MELEE/RANGED/SUPPORT" and HP in-game

4. **Create Enemy Variants** (10 min) → See `ENEMY_VARIETY_SETUP.md`
   - enemy_tank.tscn (slow, 100HP, red)
   - enemy_ranger.tscn (fast, 30HP, shoots, blue)
   - Update dungeon to 5 mixed enemies

### Optional (Polish):
5. **Camera Shake + Audio** → See `AUDIO_SETUP.md`
   - CameraShake node for screen shake
   - AudioStreamPlayer nodes for sound effects

---

## ✅ COMPLETED CODE IMPLEMENTATIONS

### Session Summary - Nov 2024
- [x] All 3 archetypes with distinct attacks (Warrior melee, Mage ranged, Support extended)
- [x] Archetype selection system (ArchetypeSelector.gd)
- [x] Skill display UI (SkillDisplayUI.gd - shows MELEE/RANGED/SUPPORT)
- [x] Victory/Death screens with stats (ResultScreen.gd)
- [x] Enemy variety system (Chaser/Tank/Ranger types in Enemy.gd)
- [x] Projectile system for ranged attacks (Projectile.gd)
- [x] Simplified archetype system (no random stats, just playstyles)
- [x] Stats tracking (time, kills, damage dealt)

### Bug Fixes Applied
- [x] Fix projectile preload error (load on-demand)
- [x] Fix victory/death screen border_width_all for Godot 4
- [x] Fix result screen cleanup and scene transitions
- [x] Fix auto-return timer and manual return

### Earlier Completed
- [x] Increase player movement speed (200 → 300)
- [x] Add attack cooldown system (0.4s between attacks)
- [x] Add visual feedback for attacks (sprite pulse)
- [x] Add enemy hit effects (knockback, flash, hit-stop)
- [x] Add camera shake system code
- [x] Add audio hooks (ready for sound files)

---

## 📚 AVAILABLE SETUP GUIDES

- `PROJECTILE_SETUP.md` - Create projectile scene
- `ARCHETYPE_SETUP.md` - Add archetype selectors to hub
- `SKILL_UI_SETUP.md` - Add skill display to dungeon
- `ENEMY_VARIETY_SETUP.md` - Create Tank/Ranger variants
- `AUDIO_SETUP.md` - Add camera shake and audio nodes
- `CLAUDE.md` - Full architecture documentation

---

## 🎮 FRIEND PLAYTEST - What Works Now

### Core Loop
- Hub with 3 difficulty portals ✅
- Select archetype (Warrior/Mage/Support) ✅
- Enter dungeon, kill enemies ✅
- Victory screen with stats ✅
- Return to hub and retry ✅

### Archetypes (Simple & Clear)
- **MELEE**: Close combat, 150 HP
- **RANGED**: Projectile shooter, 80 HP
- **SUPPORT**: Extended range, 100 HP (healing for co-op later)

### Enemy Variety (After Setup)
- Chaser: Fast melee
- Tank: Slow, tanky, high damage
- Ranger: Shoots back at player

### UI/Feedback
- Simplified archetype display (no confusing numbers)
- Victory/Death screens with replay messaging
- Stats tracking (time, kills, damage)

---

## 🚀 POST-PLAYTEST (After Friend Feedback)

### Re-enable Build Variety
- [ ] Uncomment skill randomization in PlayerController.gd
- [ ] Uncomment Portal.gd skill randomization call
- [ ] Show skill numbers in SkillDisplayUI.gd
- [ ] "High roll" runs with better stats

### Progression System
- [ ] Add loot/reward system after clearing dungeons
- [ ] Implement permanent upgrades/unlocks
- [ ] Add currency/resource system
- [ ] Save player progress between sessions

### Polish
- [ ] Add actual sound effect audio files
- [ ] Add background music (hub + dungeon)
- [ ] Floating damage numbers
- [ ] "Press E to Enter" prompt at portals
- [ ] Particle effects for combat
- [ ] Attack animations

### More Content
- [ ] More dungeon layouts for each difficulty
- [ ] Boss encounters for hard difficulty
- [ ] Additional enemy types
- [ ] Obstacles and dungeon hazards
- [ ] Procedural dungeon generation

---

## 🐛 KNOWN ISSUES

- None currently (all bugs from today's session fixed!)

---

## 💡 IDEAS / BACKLOG

- Equipment/inventory system
- Co-op multiplayer (code already has co-op considerations!)
- Achievement system
- Meta-progression between runs
- Support archetype healing abilities (when co-op added)

---

## 📝 NOTES FOR NEXT SESSION

**If starting fresh:**
1. Run `git log` to see what was done
2. Read this TODO.md for current state
3. Check `CLAUDE.md` for architecture
4. All code is committed and pushed to GitHub

**Current Branch:** master
**Last Commit:** Simplify archetype system for friend playtest
**Repository:** https://github.com/akuidox/RogueLiteUO
