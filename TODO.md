# How To Run `diff` Instead
Instead of Beyond Compare, the initial check could be done with `diff` and `lnav` combo.
```bash
$ diff -U1 xvm/default latest/res_mods/configs/xvm/default/|lnav
diff -U0 xvm/default/battle.xc latest/res_mods/configs/xvm/default/battle.xc
--- xvm/default/battle.xc       2019-12-20 09:25:33.000000000 +0200
+++ latest/res_mods/configs/xvm/default/battle.xc       2020-01-30 20:48:10.000000000 +0200
@@ -12 +12 @@
-    "showPostmortemTips": false,
+    "showPostmortemTips": true,
@@ -28 +28 @@
-    "sixthSenseDuration": 4000,
+    "sixthSenseDuration": 2000,
...
```

From that output one can easily see own customizations. Mine are mainly of type `true`/`false`. If the command outputs large chunks of text, then those chunks most probably need to be merged into this repo's codebase.

However, one can use Beyond Compare's "diff only" view when comparing files. Then unchanged lines are filtered out, and the UI only shows a couple of lines highlighting those `true`/`false` differences.