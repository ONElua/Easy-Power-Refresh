--[[ 
	Easy Power Refresh
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Onelua Team.
	Collaborators: Chronoss & Wzjk.
]]


SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE	= string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)

function onAppInstall(step, size_argv, written, file, totalsize, totalwritten)

	if back then back:blit(0,0) end

	if step == 2 then												--Confirmation
		os.delay(10)
		return 10 -- Ok
	elseif step == 4 then											-- Installing
		screen.print(910,30,"Easy Power Refresh",1,color.white,color.blue,__ARIGHT)
		screen.print(910,60,"v2.0",1,color.white,color.blue,__ARIGHT)
		screen.print(70,50,strings.install,1,color.white,color.blue)
		screen.print(10,435,title, 0.9, color.white, color.green, __ALEFT)
		screen.print(10,470,version, 0.9, color.white, color.green, __ALEFT)
		screen.flip()
	end

end

function usbMassStorage()

	local bufftmp = screen.buffertoimage()
	while usb.actived() != 1 do
		buttons.read()
		power.tick(1)

		if bufftmp then bufftmp:blit(0,0) elseif back then back:blit(0,0) end

		local titlew = string.format(strings.connectusb)
		local w,h = screen.textwidth(titlew,1) + 30,70
		local x,y = 480 - (w/2), 272 - (h/2)

		draw.fillrect(x, y, w, h, color.new(0x2f,0x2f,0x2f,0xff))
		draw.rect(x, y, w, h,color.white)
			screen.print(480,y+13, strings.connectusb,1,color.white,color.black,__ACENTER)
			screen.print(480,y+40, SYMBOL_CIRCLE.." "..strings.cancelusb,1,color.white,color.black,__ACENTER)
		screen.flip()

		if buttons.circle then return false end
	end

	buttons.read()--fflush

	--[[
		// 0:	USBDEVICE_MODE_MEMORY_CARD
		// 1:	USBDEVICE_MODE_GAME_CARD
		// 2:	USBDEVICE_MODE_SD2VITA
		// 3:	USBDEVICE_MODE_PSVSD
		"ux0:","ur0:","uma0:","gro0:","grw0:"
	]]
	local mode_usb = -1
	local title = string.format(strings.usbmode)
	local w,h = screen.textwidth(title,1) + 120,145
	local x,y = 480 - (w/2), 272 - (h/2)
	while true do
		buttons.read()
		power.tick(1)
		if bufftmp then bufftmp:blit(0,0) elseif back then back:blit(0,0) end

		draw.fillrect(x, y, w, h, color.new(0x2f,0x2f,0x2f,0xff))
			screen.print(480, y+5, title,1,color.white,color.black, __ACENTER)
			screen.print(480,y+35,SYMBOL_CROSS.." "..strings.sd2vita, 1,color.white,color.black, __ACENTER)
			screen.print(480,y+55,SYMBOL_SQUARE.." "..strings.memcard, 1,color.white,color.black, __ACENTER)
			screen.print(480,y+75,SYMBOL_TRIANGLE.." "..strings.gamecard, 1,color.white,color.black, __ACENTER)
			screen.print(480,y+100,SYMBOL_CIRCLE.." "..strings.cancel, 1,color.white,color.black, __ACENTER)
		screen.flip()

		if buttons.released.cross or buttons.released.square or
			buttons.released.triangle or buttons.released.circle then break end
	end--while

	if buttons.released.cross then			-- Press X
		mode_usb = 2
	elseif buttons.released.square then		-- Press []
		mode_usb = 0
	elseif buttons.released.triangle then	-- Press Triangle
		mode_usb = 1
	else
		return
	end

	local conexion = usb.start(mode_usb)
	if conexion == -1 then os.message(strings.usbfail,0) return end

	local titlew = string.format(strings.usbconnection)
	local w,h = screen.textwidth(titlew,1) + 30,70
	local x,y = 480 - (w/2), 272 - (h/2)
	while not buttons.circle do
		buttons.read()
		power.tick(1)

		if bufftmp then bufftmp:blit(0,0) elseif back then back:blit(0,0) end

		draw.fillrect(x,y,w,h,color.new(0x2f,0x2f,0x2f,0xff))
		draw.rect(x,y,w,h,color.white)
			screen.print(480,y+13, strings.usbconnection,1,color.white,color.black,__ACENTER)
			screen.print(480,y+40, SYMBOL_CIRCLE.." "..strings.cancelusb,1,color.white,color.black,__ACENTER)
		screen.flip()
	end

	usb.stop()

	--Update Search Nonpdrm games
	scan.app()
	infodevices()
	buttons.read()--fflush

end

--[[
	## Library Scroll ##
	Designed By DevDavis (Davis Nuñez) 2011 - 2016.
	Based on library of Robert Galarga.
	Create a obj scroll, this is very usefull for list show
	]]
function newScroll(a,b,c)
	local obj = {ini=1,sel=1,lim=1,maxim=1,minim = 1}

	function obj:set(tab,mxn,modemintomin) -- Set a obj scroll
		obj.ini,obj.sel,obj.lim,obj.maxim,obj.minim = 1,1,1,1,1
		--os.message(tostring(type(tab)))
		if(type(tab)=="number")then
			if tab > mxn then obj.lim=mxn else obj.lim=tab end
			obj.maxim = tab
		else
			if #tab > mxn then obj.lim=mxn else obj.lim=#tab end
			obj.maxim = #tab
		end
		if modemintomin then obj.minim = obj.lim end
	end

	function obj:max(mx)
		obj.maxim = #mx
	end

	function obj:up()
		if obj.sel>obj.ini then obj.sel=obj.sel-1
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
		end
	end

	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1
		elseif obj.lim+1<=obj.maxim then
			obj.ini,obj.sel,obj.lim=obj.ini+1,obj.sel+1,obj.lim+1
		end
	end

	if a and b then
		obj:set(a,b,c)
	end

	return obj

end

infoux0, infour0, infouma0 = {},{},{}
function infodevices()
	infoux0 = os.devinfo("ux0:")
	if files.exists("ur0:") then
		infour0 = os.devinfo("ur0:")
	end
	if files.exists("uma0:") then
		infouma0 = os.devinfo("uma0:")
	end

	infoux0.maxf = files.sizeformat(infoux0.max or 0)
	infour0.maxf = files.sizeformat(infour0.max or 0)
	infouma0.maxf = files.sizeformat(infouma0.max or 0)

	infoux0.freef = files.sizeformat(infoux0.free or 0)
	infour0.freef = files.sizeformat(infour0.free or 0)
	infouma0.freef = files.sizeformat(infouma0.free or 0)

end
