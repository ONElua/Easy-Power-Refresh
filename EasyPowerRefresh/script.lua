game.close()
color.loadpalette()

back = image.load("resources/back.png")

if os.access() == 0 then
	if back2 then back2:blit(0,0) end 
	screen.flip()
	os.message("UNSAFE MODE is required for this Homebrew !!!",0)
	os.exit()
end

--Auto-Update
dofile("git/updater.lua")

------------------------------------------Main--------------------------------------------------------------
dofile("system/commons.lua")
dofile("system/scan.lua")
scan.app()
options = { "Restart PSVita", "Shutdown PSVita", "Update DB", "NoNpDrm Games"}
sel = 1

buttons.interval(10,12)
while true do
	buttons.read()

	if back then back:blit(0,0) end

	screen.print(910,10,"Easy Power Refresh",1,color.white,color.blue,__ARIGHT)
	if gamesd > 0 then
		screen.print(10,435,"Game(s) Detected: "..gamesd,1,color.white,color.blue,__ALEFT)
	end

	local y = 30
	for i=1,#options do
		if i == sel then
			draw.fillrect(48,y-2,175,21, color.blue:a(150))
			draw.rect(48,y-2,175,21, color.green:a(100))
		end
		screen.print(49,y,options[i],1.0,color.white,color.gray,__ALEFT)
		y += 25
	end

	screen.flip()

	--Controls
	if buttons.up then sel-=1 end
	if buttons.down then sel+=1 end

	if sel > #options then sel=1 end
	if sel < 1 then sel=#options end

	if buttons.cross then
		if sel == 1 then os.delay(500) power.restart()
		elseif sel == 2 then os.delay(500) power.shutdown()
			elseif sel == 3 then os.message("Your PSVita will Restart...\nand your database will be update")
								 os.updatedb()
								 os.delay(500)
								 power.restart()
				elseif sel == 4 then scan.install() buttons.homepopup(1)
		end
	end

	if buttons.circle then os.exit() end

end
