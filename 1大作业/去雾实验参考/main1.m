%�����ȥ����򣬴��ڰױ�����
clc;
clear all;

tic; % ��������ʱ��

I = double( imread('./����ͼ/pumpkins.jpg'));
OriImage=I./max(I(:));    % ��һ������


% ���ܣ���ȡ��ͨ��ͼ��
%%%%%%%%%%%%%%%%%%%%%%%%%
DarkImage  = min(OriImage,[],3);  % ÿһ�����ص���������ɫͨ���е���Сֵ���൱�ڷֲ��б����ľ����ֵ
Idark=Get_DarkChannel(DarkImage,15); %��ȡ��ͨ��
%%%%%%%%%%%%%%%%%%%%%%%%%

% ���ܣ���ȡ����A�Ĺ���
A = airlight(OriImage, Idark); % ���������

% ���ܣ����㴫�亯��
A1=max(A(:));  % ѡȡ����ͨ�������Ĵ�����ֵ�������㴫�亯��
t = 1 - 0.95*(Idark./A1);  % ���㴫�亯��
t0=0.1;  % ���亯����ֵ

Recover=zeros(size(OriImage));   % �趨��ԭͼƬ��С

Recover(:,:,1) = ((OriImage(:,:,1) - A(1))./max(t,t0))+A(1);     % Rͨ��ȥ��ԭ��ʽ
Recover(:,:,2) = ((OriImage(:,:,2) - A(2))./max(t,t0))+A(2);     % Gͨ��ȥ��ԭ��ʽ
Recover(:,:,3) = ((OriImage(:,:,3) - A(3))./max(t,t0))+A(3);     % Bͨ��ȥ��ԭ��ʽ

toc; % ��������ʱ��

figure,imshow(OriImage),title('����ͼ��');
% figure,imshow(Idark),title('��ͨ��');
% figure,imshow(t),title('���亯��');
figure,imshow(Recover),title('ȥ����ͼ��');