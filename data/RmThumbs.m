function RmThumbs( targetDirectory )
     FolderList = dir(targetDirectory);
     cd (['./',targetDirectory]);
   for i = 3:length(FolderList)	
       SetList = dir(FolderList(i).name);
       nSetList = length(SetList);
        cd(['./',FolderList(i).name]);      
       
       for j = 3:nSetList
	    if(SetList(j).name(1) == 'T')
	    delete(SetList(j).name);
	        end
     end
     
     cd('../');      
     
  end
  cd('../');
end

