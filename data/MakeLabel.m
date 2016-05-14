function MakeLabel( targetDirectory, filename )
fileID = fopen(filename , 'w');
       FolderList = dir(targetDirectory);

for i = 3 : length(FolderList)
       SetList = dir([targetDirectory,'/',FolderList(i).name]);        
       nSetList = length(SetList);
       
       for j = 3:nSetList

           label = SetList(j).name(3);
           if(uint8(label)>=65 && uint8(label)<=90 ) % A~Z
          	cname = uint8(label)- 54-11; % 11 = 'A'
           
  %         elseif(uint8(label)>=97 && uint8(label)<=122 )
  %         	cname = uint8(label)- 60; % 37 = 'a'

           else
          	cname = uint8(label)- 48;
           endif
           
           fprintf(fileID, '/%s/%s %d', FolderList(i).name,SetList(j).name, cname);
           fprintf(fileID, '\r\n');
       end
end  
  
fclose(fileID);
end