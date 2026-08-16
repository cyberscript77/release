# Legacy files — DO NOT install these into the game

These two files were shipped in `mod/data/` in Cyberscript 5.1.4 and earlier.
They are **not loaded by any Cyberscript Lua code** — they exist only as
reference templates. Unfortunately, the old wiki instructed users (and some
downstream mod authors) to manually copy them into the game's
`r6/config/` directory, which caused the widespread **"F-key stops working
in quickhack / dialog / exit-vehicle"** bug:

- `inputUserMappings.xml` re-asserts `IK_F` as the binding for
  `selectChoice`, `selectChoiceUI`, and `exitVehicle` in **17 places**,
  overriding any user rebinding.
- `settings.lua` ships a complete CP2077 settings template that likewise
  hard-codes `IK_F` defaults for those same actions.

## Why they were moved (B-06 / B-20 fix)

Moving them out of the active mod path (`mod/data/`) into
`mod/data/legacy/` prevents accidental installation and the resulting
key-binding conflict. The Cyberscript mod itself never reads either file —
verified by grepping every `*.lua` in `mod/modules/` and `mod/init.lua` for
references to `inputUserMappings.xml` / `data/settings.lua` (zero matches).

## What to do if you previously installed these files

1. Delete `bin/x64/plugins/cyber_engine_tweaks/mods/cyberscript/mod/data/inputUserMappings.xml`
   if present (it is no longer shipped here).
2. Check your game's `r6/config/inputUserMappings.xml` — if you (or a mod
   manager) copied the Cyberscript version there, restore the backup or
   verify your quickhack/dialog/exit-vehicle keys in the game's Options →
   Key Bindings screen.
3. Re-bind `selectChoice` / `selectChoiceUI` / `exitVehicle` in-game if
   needed.

## Downstream mod authors

If your mod previously relied on reading `mod/data/settings.lua` directly
(none currently do, per the research report), please read your own copy of
the template from your mod's directory instead. The Cyberscript Lua runtime
does not and never did apply these settings to the game.

— Cyberscript CP2077 fork, bug-fix pass (B-06 / B-20)
