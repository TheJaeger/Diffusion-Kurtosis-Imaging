function dockerCompile
%   Compile Designer for Docker deplyoment into MAMA-MIA Docker image
%   Just run function in designer working directory to compile Designer
%   into an executable
%   Ex:
%       >> dockerCompile

outputPath = fullfile(pwd,'CompiledFiles');
baseFolder = pwd;
desFolder = fullfile(pwd,'designer');
%   Reset Relevant Folder
% if isdir(outputPath)
%     rmdir(outputPath,'s');
%     mkdir(outputPath);
% else
%     mkdir(outputPath);
% end

%% Files to Compile
tensor = fullfile(baseFolder,'tensorfitting.m');
run_smoothing = fullfile(desFolder,'runsmoothing.m');
gibbs = fullfile(desFolder,'rungibbscorrection.m');
outlier = fullfile(desFolder,'outlierdetection.m');
dki_fit = fullfile(baseFolder,'dki_fit.m');
dki_param = fullfile(baseFolder,'dki_parameters.m');
smoothing = fullfile(baseFolder,'smoothing.m');
wmti = fullfile(baseFolder,'wmti_parameters.m');
irlls = fullfile(baseFolder,'IRLLS/irlls.m');

%% Folders to Compile
niftiPath = fullfile(desFolder,'NIfTI_20140122');
median = fullfile(baseFolder,'Median_Filter');
extras = fullfile(baseFolder,'Extras');

%% Dependencies
dirs10000 = fullfile(baseFolder,'dirs10000.mat');;
dirs15 = fullfile(desFolder,'dirs15.txt');
dirs30 = fullfile(desFolder,'dirs30.txt');

%% Run Compiler
mcc('-v','-m',tensor,'-o','tensorfitting',...
    '-a',run_smoothing,...
    '-a',gibbs,...
    '-a',outlier,...
    '-a',dki_fit,...
    '-a',dki_param,...
    '-a',smoothing,...
    '-a',wmti,...
    '-a',irlls,...
    '-a',niftiPath,...
    '-a',median,...
    '-a',dirs10000,...
    '-a',dirs15,...
    '-a',dirs30,...
    '-d',outputPath);

%% Copy Python Files
copyfile(fullfile('designer','designer.sh'),...
    fullfile(outputPath,'designer.sh'));
copyfile(fullfile('designer','designer.py'),...
    fullfile(outputPath,'designer.py'));
end