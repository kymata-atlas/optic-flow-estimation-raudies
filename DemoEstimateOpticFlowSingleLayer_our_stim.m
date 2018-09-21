clc
clear all
close all

% *************************************************************************
% Estimation of optic flow for the image sequence "Translation Sphere".
% This sequence contains only one layer of motion and, thus, I only use
% methods that support the estimation of one layer motion. I do not
% compute estimation errors. For a comprehensive evaluation of optic flow
% methods see http://vision.middlebury.edu/flow/eval/.
% For the evaluation of these algorithms I created another image sequence
% "TranslationSphere" because known benchmark sequences typically do not 
% provide enough frames for all methods.
%
% Attention: This script may take tens of seconds to finish!
% 
%   Copyright (C) 2013  Florian Raudies, 05/16/2013, Boston University.
%   License, GNU GPL, free software, without any warranty.
% *************************************************************************

% Some algorithms would require more mechanisms to detect multiple speeds,
% more directions, etc. To avoid long runtimes and for educational reasons 
% I kept the scripts rather simple. Thus, results give only a guideline as
% to how good these methods are.
algoIndex = 4; % Select the algorithm to run with this index.
%                   Authors         frames        no
AlgoNameFrames = {{'AdelsonBergen', 'all'}, ... % 1
                  {'Farnebaeck',    'all'}, ... % 2
                  {'FleetJepson',   'all'}, ... % 3
                  {'Heeger',        'all'}, ... % 4
                  {'HornSchunck',   'two'}, ... % 5
                  {'LucasKanade',   'two'}, ... % 6
                  {'MotaEtAl',      'all'}, ... % 7
                  {'Nagel',         'all'}, ... % 8
                  {'OtteNagel',     'all'}, ... % 9
                  {'UrasEtAl',      'all'}};    % 10
              
contour = [];
for first_frame = 1:60

% Load the image sequence.
ImgSeq        = stream_our_stim(first_frame, 15, 'greyscale');
maxSpeed      = 10; % Set to a reasonable value, might not be correct.

% if strcmp(AlgoNameFrames{algoIndex}{2},'two'),
%     ImgSeq = ImgSeq(:,:,11:12);
% end

warning_state = warning;
warning('off', 'all');
[Dx, Dy, ~] = Farnebaeck.estimateOpticFlow2D(ImgSeq);
warning(warning_state);

% Contour captures horizontal motion energy
contour = [contour, mean(Dx(:))];

% Display the estimated optic flow.
% h       = size(ImgSeq,1);
% w       = size(ImgSeq,2);
% [Y, X]   = ndgrid(1:h, 1:w); % pixel coordinates.
% sample  = 8;
% IndexX  = 1:sample:w;
% IndexY  = 1:sample:h;
% % For the display the flow is scaled by division with its maximum speed and
% % multiplication with the sampling factor.
% len     = sample/maxSpeed;
% 
% figure('Position',[50 50 600 600]);
% quiver(X(IndexY,IndexX),      Y(IndexY,IndexX),...
%        Dx(IndexY,IndexX)*len, Dy(IndexY,IndexX)*len,0,'-k');
% axis equal ij; axis([-10 w+10 -10 h+10]);
% title(sprintf(['Our stimulus, sampling %d times of ',...
%     '%d x %d pixels.\nAlgorithm: %s'], sample,h,w,AlgoNameFrames{algoIndex}{1}));

end
