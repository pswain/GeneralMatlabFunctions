function [ assigments ] = simpleCellSelectGUI(img,assignments )
% [ assigments ] = simpleCellSelectGUI(show_img,initial_assignments )
%
% a simple gui for select and removing cells in an image. takes an image
% (img) and a labelled img (just a bwlabel of a logical). It then displayed
% the image with a jet color map for inspection and another copy with
% the assigments colour coded and overlaid. The user can then click to
% change the assignment as followed:
%
% right click  =>  remove an area
% series of left clicks terminated with a right click => draws an area
% which is then added as a new area to the assignment image.
% 
% when the user is satisfied, press enter to terminate the process and
% obtain the assignment image.
%
% based on the getline function.

if nargin<2 || isempty(assignments)
    assignments = zeros(size(img));
end

img = double(img);
f_show = figure;
imshow(img,[]);
colormap('jet');
img = img-min(img(:));
img = img/max(img(:));
img = repmat(img,[1,1,3]);

f = figure('Menu','none');

keep_select = true;

while keep_select 
    figure(f);
    show_img = makeShowImage(img,assignments);
    imshow(show_img,[]);
    selected_line = getline('closed');
    switch size(selected_line,1);
        case 0
            %pressed enter => end selection
            keep_select = false;
        case 2
            %just right click => remove a cell
            to_remove = assignments(round(selected_line(1,2)),round(selected_line(1,1)));
            if to_remove>0
                assignments(assignments==to_remove) = 0;
                assignments(assignments>to_remove) = assignments(assignments>to_remove) -1;
            end
        otherwise
            % line => add a cell
            area = areaFromPolygon(selected_line,size(assignments));
            assignments(area) = 0;
            assignments(area) = max(assignments(:)) +1;       
    end

end

close(f);
close(f_show);

end

function show_img = makeShowImage(img,assignment)

    show_img = 0.8*img + 0.2*(double(label2rgb(assignment,'jet','k'))/255);

end