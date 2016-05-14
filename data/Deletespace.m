function Deletespace( targetDirectory )
     FolderList = dir(targetDirectory);
     cd (['./',targetDirectory]);
   for i = 3:length(FolderList)	
       SetList = dir(FolderList(i).name);
       nSetList = length(SetList);
        cd(['./',FolderList(i).name]);      
       
       for j = 3:nSetList
          k = strfind(SetList(j).name, ' '); % find space
          if(length(k) == 0)
          continue;
          end
          newname =strcat(SetList(j).name(1:k),SetList(j).name(k+1:length(SetList(j).name)));
          movefile(SetList(j).name, newname);
     end
     
     cd('../');      
     
  end
  cd('../');
end

