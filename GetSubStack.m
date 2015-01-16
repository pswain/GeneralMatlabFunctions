function [ SubStackCell ] = GetSubStack( Stack,Centres,SizeOfSubStack,varargin )
% [ SubStackCell ] = GetSubStack( Stack,Centres,SizeOfSubStack,varargin )
% Returns sections of a NxMxL matrix defined by Centres and SizeOfSubStack.
% Centres given as matrix dimensions [Y X Z]
% intend it to be able to do this for various different cases but let's stick
% with just the simplest for now. 
% If the size of substack is not odd then the centre will be
% taken to be 1 less in every direction.

SubStackCell = {};
StackSize = size(Stack);

if nargin<4
    PadImage = false;
else
    PadImage = logical(varargin{1});
end

if PadImage
    %not implemented yet
else
    
    extent = ceil(SizeOfSubStack/2);
    range = cell(length(SizeOfSubStack),1);
    
    for centrei = 1:size(Centres,1)
        
        ReturnStack = true;
        
        for dimensioni =1:length(SizeOfSubStack)
            if dimensioni<=size(Centres,2)
                range{dimensioni} = Centres(centrei,dimensioni) - extent(dimensioni)  + (1:SizeOfSubStack(dimensioni));
                %centres for odd sizes
                %for even sizes(not recommended) stack is up down from 'true'
                %fractional centre.
            else
                range{dimensioni} = ceil(StackSize(dimensioni)/2) - extent(dimensioni) + (1:SizeOfSubStack(dimensioni));
            end
                
        
            
            
            if range{dimensioni}(1)<1 || range{dimensioni}(end)>StackSize(dimensioni)
                ReturnStack = false;
            end

        
        end
        
        if ReturnStack
            
            SubStackCell{centrei} = Stack(range{1},range{2},range{3});
            
        end
        
    end
    
end
