function dataArrangeByLabelWithoutCollision( targetName )

outFolderName = 'arrangedDataset';

if isdir(targetName)
    arrangeFolder(targetName, outFolderName);
    return;
end

arrangeFile(targetName, outFolderName);

end



function arrangeFolder( targetDirectory, outFolderName )

listing = dir(targetDirectory);

nList = length(listing);
for i = 1:nList
    if listing(i).isdir
        if strcmp(listing(i).name, '.') || strcmp(listing(i).name, '..')
            continue;
        end
        nextTargetDir = [targetDirectory, '/', listing(i).name];
        arrangeFolder(nextTargetDir, outFolderName);
    else
        targetFile = [targetDirectory, '/', listing(i).name];
        arrangeFile(targetFile, outFolderName);
    end
end

end



function arrangeFile( targetFile, outFolderName )

targetFileName = strsplit(targetFile, '/');
targetFileName = targetFileName{end};

targetFileExtension = strsplit(targetFileName, '.');
targetFileExtension = targetFileExtension{end};

if ~strcmp(targetFileExtension, 'bmp')
    return;
end

label = strsplit(targetFileName, '_');
label = label{1};

if label(1) == 'N' || label(1) == 'L' || label(1) == 'U'
    if length(label) > 4
        label = ['Others/', label];
    end
elseif label(1) == 'W'
    label = ['Others/', label];
else
    label = 'Others/etc';
end

targetDirectory = [outFolderName, '/', label];

if ~isdir(targetDirectory)
    mkdir(targetDirectory);
end

outTarget = [targetDirectory, '/', targetFileName];
if exist(outTarget, 'file') == 2
    outTarget = changeTarget( targetDirectory, targetFileName );
end

copyfile(targetFile, outTarget);

end



function newTarget = changeTarget( oldTargetDirectory, oldTargetFileName )

oldTargetFileNameSplitted = strsplit(oldTargetFileName, '.');

numberCollision = 1;
while 1
    newTargetFileNeme = [oldTargetFileNameSplitted{end-1}, '_(', num2str(numberCollision), ').bmp'];
    newTarget = [oldTargetDirectory, '/', newTargetFileNeme];

    if exist(newTarget, 'file') == 2
        numberCollision = numberCollision + 1;
        continue
    end
    
    break
end

end