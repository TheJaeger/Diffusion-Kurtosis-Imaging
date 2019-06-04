function dockerCompile
%   Compile Designer for Docker deplyoment into MAMA-MIA Docker image
%   Just run function in designer working directory to compile Designer
%   into an executable
%   Ex:
%       >> dockerCompile

outputPath = 'CompiledFiles'
baseFolder = pwd;
desFolder = fullfile(pwd,'designer');
%   Reset Relevant Folder
if isdir(outputPath)
    rmdir(outputPath,'s');
    mkdir(outputPath);
else
    mkdir(outputPath);
end

%% Files to Compile
tensor = '/Users/sid/Repos/DKI-Designer/designer/tensorfitting.m';
run_smoothing = '/Users/sid/Repos/DKI-Designer/designer/runsmoothing.m';
gibbs = '/Users/sid/Repos/DKI-Designer/designer/rungibbscorrection.m';
outlier = '/Users/sid/Repos/DKI-Designer/designer/outlierdetection.m';
dki_fit = '/Users/sid/Repos/DKI-Designer/dki_fit.m';
dki_param = '/Users/sid/Repos/DKI-Designer/dki_parameters.m';
smoothing = '/Users/sid/Repos/DKI-Designer/smoothing.m';
wmti = '/Users/sid/Repos/DKI-Designer/wmti_parameters.m';
irlls = '/Users/sid/Repos/DKI-Designer/IRLLS/irlls.m';

%% Folders to Compile
niftiPath = '/Users/sid/Repos/DKI-Designer/designer/NIfTI_20140122';
median = '/Users/sid/Repos/DKI-Designer/Median_Filter';
extras = '/Users/sid/Repos/DKI-Designer/Extras';

%% Dependencies
dirs10000 = '/Users/sid/Repos/DKI-Designer/dirs10000.mat';
dirs15 = '/Users/sid/Repos/DKI-Designer/designer/dirs15.txt';
dirs30 = '/Users/sid/Repos/DKI-Designer/designer/dirs30.txt';

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