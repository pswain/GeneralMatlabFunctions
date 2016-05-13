%% general image processing script. 

% here I (Elco) have collected a few useful image processing techniques for
% general images.
% the different modules can be tried in different sequences with changes of
% parameter to get a rough image processing
%
% parameters are roughly chosen for 60x 512 by 512 images and the
% segmentation of fluorescent images

%% load image as img

[file,path] = uigetfile('*.*','please select and image file that can be read by matlab');
img = imread([path file]);
figure(1);
title('raw image')
imshow(img,[])

%% processing for segmentation is perfomred on Img_mod
img_mod = double(img);



%% log

% brings images to a more reasonably scale

img_mod = log(img_mod+1);

%% minfilt

% good for noise/peak removal.

img_mod = minfilt2(img_mod,[5 5],'same');

%% subtract medfilt

% good to remove background trend and reduce the intensity of edges between
% bright objects

img_mod = img_mod - medfilt2(img_mod,[20 20]);

%%

% same but the average rather htan median

f = fspecial('disk',20);
img_mod = img_mod - imfilter(img_mod,f,'symmetric','same');

%%

% often useful to run after the above two blocks.
img_mod(img_mod<0) = 0;


%% smooth

% smooth image with a disk.

f = fspecial('disk',5);
img_mod = imfilter(img_mod,f,'same');


%% show modified image for inspection


figure(2);
title('modified image')
imshow(img_mod,[])
colormap('jet')
%imshow(img_mod>mean(img_mod(:)),[])


%% look at values
imtool(img_mod,[])

%% run a chan vese algorithm to group bright/dim objects

% pretty good for giving a relatively smoother outline


iterations = 100;
u = demo_acwe_mod(img_mod,iterations);

%% as above but without showing output.

% lambda 1/2 are good to play with for smoother/less smooth outlines.

mu=1;
lambda1=1; lambda2=1;
timestep = .1; v=1; epsilon=1;


c0=2;
loc = img_mod>=prctile(img_mod(:),95);
u = zeros(size(img));
u(loc) = c0;
u(~loc) = -c0;

u = acwe(u, img_mod,  timestep,...
             mu, v, lambda1, lambda2, 1, epsilon, 1);

%% threshold result and fill in holes
loc = imfill(u>0,'holes');

%%
cell_label = bwlabel(loc);

%% watershed

% gives separated parts different labels and uses watershed to break up
% convex shapes (like two round cells confused as one lump)
% min filt removes little line breaks, ensures only big sections separated.
cell_identity = watershed(minfilt2(-bwdist(~loc),[3 3],'same'));
%cell_identity = watershed(-bwdist(~loc));
cell_label = zeros(size(loc));
cell_label(loc) = cell_identity(loc);

imshow(cell_label,[])

%% small viewing and editing gui

help simpleCellSelectGUI;

cell_label = simpleCellSelectGUI(double(img),cell_label);
