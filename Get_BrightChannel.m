function RawDarkChannel = Get_BrightChannel (OriImage,sizeOfBlock)
%
% -------------------------------------------------------------------------
% 如下的程序段用于从原图像中获取原始的暗通道图像
[mImage,nImage,tImage] = size (OriImage); 
PatchSize = sizeOfBlock;
PadWidth = (PatchSize-1)/2;
RawDPaddedImage = padarray( OriImage,[PadWidth,PadWidth],'symmetric');

RawDarkChannel = zeros( mImage ,nImage ); 
for i = 1 : mImage
    for j = 1 : nImage
        TmpPatch = RawDPaddedImage( i:(i+PatchSize-1) ,j:(j+PatchSize-1) , : );
        RawDarkChannel(i,j) = max( TmpPatch(:) );%min
    end    
end 
