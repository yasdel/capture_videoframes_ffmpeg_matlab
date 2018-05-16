function [] = segmentVideos2FramesAudio(videoParams,audioParams,batchNo,strVideo,endVideo,inputAddrss,outputVidFld,outputAudFld,flagVideoON,flagAudioON)


% Inputs:
%          videoDir : The Video Input Directory
%          fps      : Video Sampling Rate (fps)
%          w        : Width of the Image
%          h        : Height of the Image
%          Fs       : Sampling Frequency
%     outputVidDir  : Output Video Directory
%     outputAudDir  : Output Audio Directory

 fps = videoParams.fps    ; 
   w = videoParams.w     ;
   h = videoParams.h     ;
extV = videoParams.ext   ; 
  Fs = audioParams.Fs    ;
extA = audioParams.ext   ;


if exist(outputVidFld) == 0    
     mkdir(outputVidFld) ; 
end

if exist(outputAudFld) == 0    
     mkdir(outputAudFld) ; 
end


 




        fileID = fopen(fullfile(outputVidFld,['log_Part' num2str(batchNo) '.txt']),'a');
videoFilesList = dir(inputAddrss);


for mov = strVideo : endVideo

    currentVideo = videoFilesList(mov+2).name ;    
    
    if flagVideoON == 1
        outputVideoSubfld = fullfile(outputVidFld,strtok(currentVideo,'.'));
        if exist (outputVideoSubfld) == 0
            mkdir(outputVideoSubfld)
        end
        
        command = ['ffmpeg -i ' fullfile(inputAddrss,currentVideo) ' -s ' num2str(w) '*' num2str(h) ' -r ' num2str(fps) '/1 ' fullfile(outputVideoSubfld,['image-%06d.' extV])];
        [statusV,~] = system(command);
    else
        statusV = 0 ;
        
    end
    
    if flagAudioON == 1
        
        command = ['ffmpeg -i ' fullfile(inputAddrss,currentVideo) ' -vn -acodec pcm_s16le -ar ' num2str(Fs) ' -ac 2 ' fullfile(outputAudFld,[strtok(currentVideo,'.') '.' extA])];
        [statusA,~] = system(command);
    else
        statusA = 0 ;
    end
    
    
    if statusV == 0 && statusA == 0
        fprintf(fileID,'\n Movie %d: %s OK',mov,currentVideo);
    else
        fprintf(fileID,'\n Movie %d: %s NOK',mov,currentVideo); 
    end


    
end

fclose(fileID);