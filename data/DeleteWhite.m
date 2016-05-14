%%created by Kongty
%%2016.05.12
%%copy images except for white images 
%%and calculate the proportion

function DeleteWhite( targetDirectory )
numTotal = 0;
numWhite = 0;
FolderList = dir(targetDirectory);
for i = 3 : length(FolderList)
    SetList = dir([targetDirectory, '/', FolderList(i).name]);        
	nSetList = length(SetList);
    for j = 3 : nSetList
        numTotal = numTotal + 1;
        currentDirectory = [targetDirectory, '/', FolderList(i).name, '/', SetList(j).name];
        if (SetList(j).bytes < 55)
            continue;
        end
        tmpImg = imread(currentDirectory);
        
        if(size(tmpImg, 3) ~= 1)
            tmpImg = rgb2gray(tmpImg);
        end
        if(islogical(tmpImg))
            tmpImg = tmpImg * 255;
            tmpImg = uint8(tmpImg);
        end
        numOfWhitePixel = nnz(tmpImg == 255);
        numOfBlackPixel = nnz(tmpImg == 0);
        if((numOfWhitePixel > numel(tmpImg)-10) || (numOfBlackPixel > numel(tmpImg)-10) )
            %delete(SetList(j).name);
            numWhite = numWhite + 1;
            continue;
        end
        destDirectory = [targetDirectory, '_noWhite/',FolderList(i).name];
        if ~isdir([targetDirectory, '_noWhite'])
            mkdir([targetDirectory, '_noWhite']);
        end
        if ~isdir(destDirectory)
            mkdir(destDirectory);
        end
        copyfile(currentDirectory, [destDirectory, '/', SetList(j).name]);
     end
end

fileID = fopen(['output_', targetDirectory, '.txt'], 'w');
fprintf(fileID, 'number of total images: %d\r\n',numTotal);
fprintf(fileID, 'number of white images: %d\r\n',numWhite);
fprintf(fileID, 'proportion: %4.3f\r\n',numWhite/numTotal);
fclose(fileID);
end