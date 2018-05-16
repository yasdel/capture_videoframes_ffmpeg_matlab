clear 
clc
close all

% Create two folders in the root folder and name them 'inputs' and 'outputs' as follows: 

% e.g. 
% 
% 1. videoDatatset/inputs
% 2. videoDatatset/outputs
% 
% where inputs can contain may subfolders containing videos:
% 
% e.g. 
% 
% videoDatatset/inputs/T1_OriginalVideos
% videoDatatset/inputs/T2_OriginalVideos
% videoDatatset/inputs/T3_OriginalVideos

videoParams.fps   = 1        ;
videoParams.w     = 256      ;
videoParams.h     = 256      ;
videoParams.ext   = 'jpg'    ;
audioParams.Fs    = 44100    ;
audioParams.ext   = 'wav'    ;
flagVideoON       = 1        ;
flagAudioON       = 0        ;



parfor i = 1 : 6
     inputAddrss = ['G:\videoDataset\inputs\T' num2str(i) '_OriginalVideos\'];
     outputVidFld = ['G:\videoDataset\outputsVideo\T' num2str(i) '_OriginalVideos_fps' num2str(videoParams.fps) '_size' num2str(videoParams.w) '_ext' videoParams.ext '\'];
     outputAudFld = ['G:\videoDataset\outputsAudio\T' num2str(i) '_OriginalVideos_Fs'  num2str(audioParams.Fs)  '_ext' audioParams.ext '\'];

     batchNo      = i     ;
     strVideo     = 1     ;
     endVideo     = 2500  ;
     if i == 6     
         endVideo = 2365;
     end
     segmentVideos2FramesAudio(videoParams,audioParams,batchNo,strVideo,endVideo,inputAddrss,outputVidFld,outputAudFld,flagVideoON,flagAudioON)
     
 end
