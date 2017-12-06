--[[ 
	Easy Power Refresh
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Onelua Team.
	Collaborators: Chronoss & Wzjk.
]]

menuadv = {}

local root_files = "ux0:Multimedia" -- Path of Multimedia file folder...
cont_multimedia,cont_mp3,cont_img,cont_mp4 = 0,0,0,0

local restart_callback = function ()
	os.delay(500)
	power.restart()
end

local shutdown_callback = function ()
	os.delay(500)
	power.shutdown()
end

local reloadconfig_callback = function ()
	menuadv.wakefunct()
	
	os.message(strings.configreload2)
	os.taicfgreload()
	os.delay(100)
	os.message(strings.configreload)
end

local updatedb_callback = function ()
	menuadv.wakefunct()
	if os.message(strings.confirmdb,1) == 1 then
		os.delay(150)
		os.updatedb()
		os.message(strings.updatedb)
		os.delay(1500)
		power.restart()
	end
end

local usb_callback = function ()
	menuadv.wakefunct()
	usbMassStorage()
end

local nonpdrm_callback = function ()
	menuadv.wakefunct()
	scan.install()
	buttons.homepopup(1)
end

local filesexport_callback = function ()
	menuadv.wakefunct()
	if os.message(strings.confirm,1) == 1 then

		scan.multimedia("ux0:Multimedia")

		if cont_multimedia > 0 then
			os.message(strings.mp3s..cont_mp3.."\n"..strings.mp4s..cont_mp4.."\n"..strings.imgs..cont_img.."\n"..strings.export)
		else
			os.message(strings.nofile)
		end
    end
	cont_multimedia,cont_mp3,cont_img,cont_mp4 = 0,0,0,0
end

local exit_callback = function ()
	os.exit()
	buttons.homepopup(1)
end
	
function menuadv.wakefunct()
	menuadv.options = {
		{ text = strings.restart,		funct = restart_callback },
		{ text = strings.shutdown,      funct = shutdown_callback },
		{ text = strings.refreshdb, 	funct = updatedb_callback },
		{ text = strings.reloadconfig,	funct = reloadconfig_callback },
		{ text = strings.usb,   		funct = usb_callback },
		{ text = strings.nonmpdrm,   	funct = nonpdrm_callback },
		{ text = strings.filesexport,	funct = filesexport_callback},
		{ text = strings.exit,   		funct = exit_callback},
	}
end
