function RmBracket(TD)
	list = dir(TD);
	cd(['./', TD]);
	for i=3:length(list)
		if(list(i).isdir)
		oname = list(i).name;
		movefile(oname, ['U(',oname,')']);
		end
		end
	cd('../');	
		
end