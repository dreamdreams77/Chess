extends Control
# Runs the Checkmate & Ruin web game from res://game/index.html.
#
# Godot has no built-in web view, so this picks the best option available:
#   1. A WebView node, if the godot-wry addon is installed (desktop). The game runs inside the window.
#   2. Otherwise, on desktop, the bundled game is copied to user:// and opened in the default browser.
#   3. Otherwise (for example on Android), a screen with a button that opens the live game in the
#      phone's browser.
#
# The game saves to browser storage, so saves live wherever it runs (wry, or your browser).

const GAME_PATH := "res://game/index.html"
const LIVE_URL := "https://dreamdreams77.github.io/Chess/"
const BG := Color("0a0c11")
const GOLD := Color("ecd08a")

func _ready() -> void:
	RenderingServer.set_default_clear_color(BG)
	if ClassDB.class_exists("WebView"):
		_start_webview()
	else:
		_show_launcher()

func _start_webview() -> void:
	# godot-wry (https://github.com/doceazedo/godot_wry) adds the WebView node.
	var web = ClassDB.instantiate("WebView")
	web.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(web)
	web.set("transparent", false)
	# godot-wry serves res:// files itself, so the page gets a normal origin and storage.
	web.call_deferred("load_url", GAME_PATH)

func _show_launcher() -> void:
	var box := VBoxContainer.new()
	box.set_anchors_preset(Control.PRESET_CENTER)
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 18)
	box.custom_minimum_size = Vector2(520, 0)
	box.grow_horizontal = Control.GROW_DIRECTION_BOTH
	box.grow_vertical = Control.GROW_DIRECTION_BOTH
	add_child(box)

	var title := Label.new()
	title.text = "CHECKMATE & RUIN"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 40)
	title.add_theme_color_override("font_color", GOLD)
	box.add_child(title)

	var note := Label.new()
	note.text = "This build has no embedded web view, so the game opens in your browser."
	note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	box.add_child(note)

	var live := Button.new()
	live.text = "Play online"
	live.pressed.connect(func(): OS.shell_open(LIVE_URL))
	box.add_child(live)

	if not OS.has_feature("android") and not OS.has_feature("ios") and not OS.has_feature("web"):
		var local := Button.new()
		local.text = "Play the bundled copy (offline)"
		local.pressed.connect(_open_local_copy)
		box.add_child(local)

func _open_local_copy() -> void:
	# A browser cannot read res://, so copy the game out to a real folder first.
	var dir := "user://game"
	DirAccess.make_dir_recursive_absolute(dir)
	var src := FileAccess.open(GAME_PATH, FileAccess.READ)
	if src == null:
		push_error("Bundled game not found at " + GAME_PATH + ". Check the export include filter.")
		return
	var out := FileAccess.open(dir + "/index.html", FileAccess.WRITE)
	out.store_string(src.get_as_text())
	out.close()
	OS.shell_open(ProjectSettings.globalize_path(dir + "/index.html"))
