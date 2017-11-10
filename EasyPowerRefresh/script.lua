--[[ 
	Easy Power Refresh
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Onelua Team.
	Collaborators: Chronoss & Wzjk.
]]

if not usb then os.requireusb() end--requiere for module USB

game.close()
color.loadpalette()

back = image.load("resources/back.png")
HDDpic = image.load("resources/HDD.png")

if os.access() == 0 then
	if back then back:blit(0,0) end 
	screen.flip()
	os.message("UNSAFE MODE is required for this Homebrew !!!",0)
	os.exit()
end

--Auto-Update
dofile("git/updater.lua")

------------------------------------------Main--------------------------------------------------------------
__LANG = os.language()
if files.exists("system/lang/"..__LANG..".txt") then dofile("system/lang/"..__LANG..".txt") 
else dofile("system/lang/english_us.txt") end

dofile("system/menu.lua")
dofile("system/commons.lua")
dofile("system/scan.lua")

--Search Nonpdrm games
scan.app()

--Load Options Menu
menuadv.wakefunct()
local scroll = newScroll(menuadv.options, #menuadv.options)

--Info (Devices) 
infodevices()

buttons.interval(10,12)
while true do
	buttons.read()

	if back then back:blit(0,0) end

	screen.print(910,30,"Easy Power Refresh",1,color.white,color.blue,__ARIGHT)
	screen.print(910,60,"v2.0",1,color.white,color.blue,__ARIGHT)

	if gamesd > 0 then
		screen.print(10,435,strings.gamefind..gamesd,1,color.white,color.blue,__ALEFT)
	end

	local y = 30
	for i=scroll.ini,scroll.lim do
		if i == scroll.sel then
			draw.fillrect(42,y-2,331,21, color.red:a(150))
			draw.rect(42,y-2,331,21, color.blue:a(125))
		end
		screen.print(49,y, menuadv.options[i].text,1.0,color.white,color.gray,__ALEFT)
		y+=25
	end

	if HDDpic then HDDpic:blit(870,428) end
	
if infouma0 then
	screen.print(860,475,"uma0: "..infouma0.maxf.."/"..infouma0.freef,1,color.red,color.blue,__ARIGHT)
	screen.print(860,455,"ur0: "..infour0.maxf.."/"..infour0.freef,1,color.yellow,color.blue,__ARIGHT)
	end
	screen.print(860,435,"ux0: "..infoux0.maxf.."/"..infoux0.freef,1,color.green,color.blue,__ARIGHT)
	

	screen.flip()

	--Controls
	if buttons.circle then os.exit() end

	if buttons.up or buttons.analogly < -60 then scroll:up() end
	if buttons.down or buttons.analogly > 60 then scroll:down() end

	if buttons.cross then
		menuadv.options[scroll.sel].funct()
	end

end
