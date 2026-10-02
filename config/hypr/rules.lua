-- Some rules from end-4 dotfiles
local floatTitles = {
    "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$",
    "^(Open File)(.*)$",
    "^(Select a File)(.*)$",
    "^(Choose wallpaper)(.*)$",
    "^(Open Folder)(.*)$",
    "^(Save As)(.*)$",
    "^(Library)(.*)$",
    "^(File Upload)(.*)$",
}

for _, title in ipairs(floatTitles) do
    hl.window_rule({ match = { title = title }, float = true })
end

hl.window_rule({ match = { class = "^(io.bassi.Amberol)$" }, float = true })

-- Picture-in-Picture
hl.window_rule({
    match = { title = "^(Picture(-| )in(-| )[Pp]icture)$" },
    keep_aspect_ratio = true,
    float = true,
    pin   = true,
})

hl.layer_rule({
    match = { namespace = "quickshell-quicksettings" },
    blur = true,
    ignore_alpha = 0
})