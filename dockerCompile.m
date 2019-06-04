function dockerCompile
%   Compile Designer for Docker deplyoment into MAMA-MIA Docker image
%   Just run function in designer working directory to compile Designer
%   into an executable
%   Ex:
%       >> dockerCompile

folderName = '/CompiledFiles'
baseFolder = pwd;
desFolder = fullfile(pwd,'designer');
%   Reset Relevant Folder
if isdir(folderName)
    rmdir(folderName,'s');
    mkdir(folderName);
else
    mkdir(folderName);
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
median = '/Users/sid/Repos/DKI-Designer/Median_Filter'

%% Files to I
%   Directories to include in compilation
gradientDir = ['.' filesep 'gradientVectors'];

%   Run compiler
fprintf('1. Compiling DKE (1/3)\n');
mcc('-v','-m','dke.m','-o','dke','-a',gradientDir,...
    '-a',mexFolder,'-d',folderName);
fprintf('\n\n');

fprintf('2. Compiling dke_preprocess_dicom (2/3)\n');
mcc('-v','-m','dke_preprocess_dicom.m','-o','dke_preprocess_dicom',...
    '-a','spm_dicom_dict.mat','-d',folderName);
fprintf('\n\n');

fprintf('3. Compiling map_interpolate (3/3)\n');
mcc('-v','-m','map_interpolate.m','-o','map_interpolation',...
    '-d',folderName);
fprintf('\n\n');
fprintf('completed\n\n')
end