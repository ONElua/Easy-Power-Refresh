--[[ 
	Easy Power Refresh.
	
	Licensed by GNU General Public License v3.0
	
	Designed By:
	- Gdljjrod (https://twitter.com/gdljjrod).
	- BaltazaR4 (https://twitter.com/BaltazaR4).
]]

function onAppInstall(step, size_argv, written, file, totalsize, totalwritten)

	buttons.homepopup(0)

	if back then back:blit(0,0) end

	if step == 2 then												--Confirmation
		os.delay(10)
		return 10 -- Ok
	elseif step == 4 then											-- Installing
		screen.print(910,10,"Easy Power Refresh",1,color.white,color.blue,__ARIGHT)
		screen.print(75,75,"Installing...",1,color.white,color.blue)
		screen.print(10,435,title, 0.9, color.white, color.green, __ALEFT)
		screen.print(10,470,version, 0.9, color.white, color.green, __ALEFT)
		screen.flip()
	end

	buttons.homepopup(1)

end

function init_msg(msg)
	if back then back:blit(0,0) end
	screen.print(910,10,"Easy Power Refresh",1,color.white,color.blue,__ARIGHT)
	screen.print(70, 50, msg, 1.0, color.white, color.cyan:a(100))
	screen.flip()
	os.delay(10)
end
