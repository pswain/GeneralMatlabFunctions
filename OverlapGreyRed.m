function [show_stack] = OverlapGreyRed(BaseImage,HighlightImage,UseNeg,HighlightImage2,TreatAsLogical)
%make an image that is grey BaseImage with red highlight of HighLightImage;

BaseImage = IMNormalise(BaseImage);

if nargin<2 || isempty(HighlightImage)
    
    HighlightImage = zeros(size(BaseImage));
    
end

if nargin<4 || isempty(HighlightImage2)
    
    HighlightImage2 = zeros(size(BaseImage));
    
end

if nargin<3 || isempty(UseNeg) || ~UseNeg

    HighlightImage = IMNormalise(HighlightImage);
    HighlightImage2 = IMNormalise(HighlightImage2);

else

    HighlightImage = IMNormalise2(HighlightImage);
    HighlightImage2 = IMNormalise2(HighlightImage2);
    
end
   
if nargin<5 || isempty(TreatAsLogical)
    TreatAsLogical = false;
end

if TreatAsLogical
    
    im1 = 0.8*BaseImage;
    im2 = im1;
    im3 = im1;
    im1(HighlightImage>0) = 1;
    im2(HighlightImage2>0) = 1;
    show_stack = cat(3,im1,im2,im3);
    
    
else    
    show_stack = repmat(BaseImage,[1 1 3]).*(cat(3,1+HighlightImage , 1+HighlightImage2 , ones(size(HighlightImage))));
    show_stack = show_stack/2;
end

end

function Image = IMNormalise(Image)

if ~islogical(Image)

Image = Image - min(Image(:));
m = max(Image(:));
if m>0
    Image = Image/(max(Image(:)));
end

end

end

function Image = IMNormalise2(Image)

if ~islogical(Image)

m = max(Image(:));
if m>0
    Image = Image/(max(Image(:)));
end

end
end