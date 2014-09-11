%% a script for setting a figures properties and then saving it as .png file 

%% for single plots

h = gcf;
set(h,'PaperUnits','centimeters',...
     'PaperPosition',[0 0 20 10]) %[0 0 width height]
set(get(h,'children'),'FontSize',12,'LineWidth',0.9)

%%
set(h,'LooseInset',get(h,'TightInset'))

%% writeup

location = '~/Dropbox/ongoing_writeup/logbook_and_notebook_images/segmentation_and_active_contour/2014_04_25_transfomedOOF.png';

%% facs locations

location = '~/Documents/FACS data/2014_07_02_ND(F)GFPstar_expression_check/Analysis/histogram';

%% by gui

dirrr = uigetdir('~/Documents');

nameeee = inputdlg('file name','name box',1,{'.png'});


%% same dir

nameeee = 'a.png'

location = fullfile(dirrr,nameeee)
%%

saveas(h,location,'png')


