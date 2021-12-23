%==========================================================================
%               ��ȡ��ͨ��( raw dark channel )
% ���۽��ͣ���ͨ����RGB�����ռ��У���ĳһ�����ص�С�����ڵ���Сֵ
%          �������ֵ�Ľ������������ͨ��ͬʱ���е���Сֵ�˲�����
% PatchSize -------------- �ֲ�ͨ���Ĵ�С�ߴ�
% PadWidth ------------- ͼ��ļӱ� һ��(PatchSize-1)/2
% RawDPaddedImage ------------- ԭʼ�İ�ͨ��ͼ��
% Ӧ���˺��� padarray

%==========================================================================
function RawDarkChannel = Get_DarkChannel (OriImage,sizeOfBlock)
%
% -------------------------------------------------------------------------
% ���µĳ�������ڴ�ԭͼ���л�ȡԭʼ�İ�ͨ��ͼ��
[mImage,nImage,tImage] = size (OriImage); 
PatchSize = sizeOfBlock;
PadWidth = (PatchSize-1)/2;
RawDPaddedImage = padarray( OriImage,[PadWidth,PadWidth],'symmetric');

RawDarkChannel = zeros( mImage ,nImage ); 
for i = 1 : mImage
    for j = 1 : nImage
        TmpPatch = RawDPaddedImage( i:(i+PatchSize-1) ,j:(j+PatchSize-1) , : );
        RawDarkChannel(i,j) = min( TmpPatch(:) );
    end    
end 





