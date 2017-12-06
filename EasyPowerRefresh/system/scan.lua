--[[ 
	Easy Power Refresh
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Onelua Team.
	Collaborators: Chrono & Wzjk.
]]


scan, gamesd = {},0

function scan.multimedia(path)

	local tmp = files.listfiles(path)
	if tmp and #tmp > 0 then

		if back then back:blit(0,0) end

		for i=1, #tmp do

			if back then back:blit(0,0) end

			screen.print(910,30,"Easy Power Refresh v2.0",0.9,color.white,color.blue,__ARIGHT)

			if down then
				down:blit(680,43)
				down:blit(880,43)
			end
			screen.print(888,62,"All useful trick in one",0.9,color.white,color.blue,__ARIGHT)
		
			if Bat then Bat:blit(900,500) end 			------ Icon bat
			screen.print(880,519,batt.lifepercent().."%",2,color.white,color.blue,__ARIGHT)

			if HDDpic then HDDpic:blit(870,428) end

			screen.print(860,435,"ux0: "..infoux0.maxf.."/"..infoux0.freef,1,color.green,color.blue,__ARIGHT)
			screen.print(860,455,"ur0: "..infour0.maxf.."/"..infour0.freef,1,color.yellow,color.blue,__ARIGHT)
			if infouma0 then
				screen.print(860,475,"uma0: "..infouma0.maxf.."/"..infouma0.freef,1,color.red,color.blue,__ARIGHT)
			end

			local ext = tmp[i].ext
			if ext:lower() == "png" or ext:lower() == "jpg" or ext:lower() == "bmp" or ext:lower() == "gif" or ext:lower() == "mp3" or ext:lower() == "mp4" then

				buttons.homepopup(0)
					screen.print(80,40, strings.wait,1.0,color.green,color.gray,__ALEFT)
					screen.print(10,435, strings.fileexport..tmp[i].name,1,color.white,color.black,__ALEFT)
					screen.flip()
					local result = files.export(tmp[i].path)
				buttons.homepopup(1)

				if result == 1 then
					cont_multimedia+=1
					if ext:lower() == "png" or ext:lower() == "jpg" or ext:lower() == "bmp" or ext:lower() == "gif" then
						cont_img+=1
					elseif ext:lower() == "mp3" then
						cont_mp3+=1
					else
						cont_mp4+=1
					end
					files.delete(tmp[i].path)
				else
					os.message(strings.fail.."\n\n"..tmp[i].name,0)
				end
				
			end
		end--for
	end

	infodevices()

end

function scan.dirapp(path)
	local tmp = files.listdirs(path)
	if tmp and #tmp > 0 then
		for i=1, #tmp do
			local info = game.info(tmp[i].path.."/sce_sys/param.sfo")
			if info then
				if info.TITLE_ID then
					if info.TITLE then info.TITLE = info.TITLE:gsub("\n"," ") else info.TITLE = "UNK" end
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
	if gamesd > 0 then
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
				os.message(strings.notinstalled..scan.apps[i].id)
			end
			icon = nil
		end
		os.cpu(333)
		os.message(strings.gamesinst..count)
		--clean
		scan.list, scan.apps = {},{}
	else
		os.message(strings.nogames)
	end
	infodevices()
end
