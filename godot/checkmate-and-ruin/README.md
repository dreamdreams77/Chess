# Checkmate & Ruin: Godot wrapper project

A Godot 4 project (4.3 or newer) that bundles the game (`game/index.html`) and runs it. The game
itself is unchanged: same rules, saves and sound. Godot does not include a web view, so what
you get depends on what is installed. See the table.

| Where you run it | Result |
|---|---|
| Desktop with the godot-wry addon | The game runs inside the Godot window |
| Desktop without the addon | "Play the bundled copy" opens the game in your browser, offline |
| Android (and anything else) | "Play online" opens the live game in the phone browser |

## Open the project
1. Install Godot 4.3 or newer from godotengine.org (the standard version, not .NET).
2. Open Godot, choose **Import**, and select this folder's `project.godot`.
3. Press **F5**. You should see a launcher with a Play online button.

## Run the game inside the Godot window (desktop)
1. In Godot, open **AssetLib**, search for **godot_wry**, and download and install it. Or get it
   from github.com/doceazedo/godot_wry and copy its `addons/godot_wry` folder into this project.
2. **Project > Project Settings > Plugins**: enable it.
3. Restart the editor and press F5. The game now loads in the window.

## Export for desktop
1. **Project > Export > Add...** and pick your platform.
2. On the **Resources** tab, set **Filters to export non-resource files** to `game/*`.
   Without this the game file is left out.
3. Export. If you use godot-wry, follow the addon's export notes so its library is included.

## Export for Android
1. Godot needs the Android build tools once: **Editor > Editor Settings > Export > Android** (set the
   Android SDK path), and install the Android export templates under **Editor > Manage Export Templates**.
   Godot's own docs, "Exporting for Android", give the step by step.
2. **Project > Export > Add... > Android**. Set a package name such as `com.yourname.checkmateandruin`.
3. Resources tab: set **Filters to export non-resource files** to `game/*`.
4. Export as an APK and install it on your phone.
5. The app opens the launcher; tap **Play online**. It needs internet and your saves live in
   the phone browser, shared with the website, so your existing campaign is there.

## Important limits
- A Godot Android app cannot show a web page inside itself without a third-party Android plugin.
  This project does not include one, so on Android it opens your browser. If you want the game fully inside the app,
  add a WebView plugin for Godot Android and call it from `main.gd` (`_start_webview`).
- To update the game, replace `game/index.html` with the newest `index.html` from the repository.
- The game's saves are in browser storage, so the wry copy, the offline browser copy and the website
  each keep their own saves.
