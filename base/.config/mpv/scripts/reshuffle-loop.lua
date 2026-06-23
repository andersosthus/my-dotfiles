local pending_reshuffle = false
local internal_change = false

local function shuffle_keep_current_first()
	local count = mp.get_property_number("playlist-count", 0)
	if count < 2 then
		return
	end

	internal_change = true

	mp.command("playlist-shuffle")

	local pos = mp.get_property_number("playlist-pos", 0)
	if pos > 0 then
		mp.commandv("playlist-move", pos, 0)
	end

	mp.osd_message("Playlist reshuffled")
	internal_change = false
end

local function enable_loop()
	mp.set_property("loop-playlist", "inf")
end

mp.register_script_message("shuffle-loop-now", function()
	enable_loop()
	shuffle_keep_current_first()
end)

mp.register_event("end-file", function(event)
	if internal_change then
		return
	end

	if event.reason ~= "eof" then
		return
	end

	local count = mp.get_property_number("playlist-count", 0)
	local pos = mp.get_property_number("playlist-pos", 0)
	local loop_playlist = mp.get_property("loop-playlist", "no")

	if count < 2 then
		pending_reshuffle = false
		return
	end

	if loop_playlist ~= "inf" then
		pending_reshuffle = false
		return
	end

	if pos == count - 1 then
		pending_reshuffle = true
	end
end)

mp.register_event("file-loaded", function()
	if internal_change or not pending_reshuffle then
		return
	end

	local count = mp.get_property_number("playlist-count", 0)
	local pos = mp.get_property_number("playlist-pos", 0)
	local loop_playlist = mp.get_property("loop-playlist", "no")

	if count < 2 or loop_playlist ~= "inf" then
		pending_reshuffle = false
		return
	end

	if pos == 0 then
		pending_reshuffle = false
		shuffle_keep_current_first()
	end
end)
