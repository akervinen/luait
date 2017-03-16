--[[plugin.register {
    --title = "Path of Exile",
    --class = "POEWindowClass"
}]]

local function helloworld()
    input.SendText("Hello, World!", key.Enter)
end
plugin.key({key.Ctrl, key.Q}, helloworld)