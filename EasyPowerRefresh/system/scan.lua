--[[ 
	Easy Power Refresh.
	
	Licensed by GNU General Public License v3.0
	
	Designed By:
	- Gdljjrod (https://twitter.com/gdljjrod).
	- BaltazaR4 (https://twitter.com/BaltazaR4).
]]

scan, gamesd = {},0

function scan.dirapp(path)
	local tmp = files.listdirs(path)
	if tmp and #tmp > 0 then
		for i=1, #tmp do
			local info = game.info(tmp[i].path.."/sce_sys/param.sfo")
			if info then
				if info.TITLE_ID then
					table.insert(scan.list, { title=info.TITLE, path=tmp[i].path, id=info.TITLE_ID, version=info.VERSION })
				end
			end
		end--for
	end
end

function scan.app()
	os.cpu(444)
	scan.list, scan.apps = {},{}
	debug_print = {}
	scan.dirapp("ux0:app")

	scan.len = #scan.list
	if scan.len > 0 then
		table.sort(scan.list ,function (a,b) return string.lower(a.id)<string.lower(b.id) end)
	end

	for i=1, scan.len do
		if game.exists(scan.list[i].id) then
			if not game.rif(scan.list[i].id) and not game.frif(scan.list[i].id) then
				table.insert(scan.apps, scan.list[i])
			end
		else
			table.insert(scan.apps, scan.list[i])
		end
	end
	gamesd=#scan.apps

	os.cpu(333)
end

function scan.install()
	local count = 0
	os.cpu(444)
	for i=1, #scan.apps do
		title,version = scan.apps[i].title,scan.apps[i].version
		buttons.homepopup(0)
			result = game.refresh(scan.apps[i].path)
		buttons.homepopup(1)
		if result == 1 then
			count+=1
			gamesd-=1
		else
			os.message("Game not installed: "..scan.apps[i].id)
		end
	end
	os.cpu(333)
	os.message("Total Installed Games: "..count)
	scan.list, scan.apps = {},{}
end
