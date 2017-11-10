--[[ 
	Easy Power Refresh
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Onelua Team.
	Collaborators: Chronoss & Wzjk.
]]

menuadv = {}

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

function menuadv.wakefunct()
	menuadv.options = {
		{ text = strings.restart,		funct = restart_callback },
		{ text = strings.shutdown,      funct = shutdown_callback },
		{ text = strings.refreshdb, 	funct = updatedb_callback },
		{ text = strings.reloadconfig,	funct = reloadconfig_callback },
		{ text = strings.usb,   		funct = usb_callback },
		{ text = strings.nonmpdrm,   	funct = nonpdrm_callback },
	}
end
