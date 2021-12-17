%���ø���֪ʶ�Ľ���ȥ����
clc;
clear all;

tic; % ��������ʱ��

%��ʼ������
r=41;
eps=0.01;

I = double( imread('./����ͼ/forest.jpg'));

OriImage=I./max(I(:));    % ��һ������


% ���ܣ���ȡ��ͨ��ͼ��
% guidedfilter�������ø�ʽ��  ��� = guidedfilter�����룬���룬r,eps��;r��eps�Ѹ���

%%%%%%%%%%%%%%%%%%%%%%%%%
DarkImage  = min(OriImage,[],3);  % ÿһ�����ص���������ɫͨ���е���Сֵ���൱�ڷֲ��б����ľ����ֵ

DarkImage_ave_local = guidedfilter(DarkImage,DarkImage , r, eps);% �����Ե��Ϣ�ľ�ֵ

a1 = (DarkImage-DarkImage_ave_local).^2; % ����

DarkImage_std_local = guidedfilter(DarkImage,a1, r, eps); % �����Ե��Ϣ�ķ���

Imin = DarkImage_ave_local-min(3.*DarkImage_std_local,0.001); % ���㰵ͨ��

Idark=min(Imin,DarkImage); % ��ֵ����
%%%%%%%%%%%%%%%%%%%%%%%%%

% ���ܣ���ȡ����A�Ĺ���
A = airlight(OriImage, Idark); % ���������

% ���ܣ����㴫�亯��
A1=max(A(:));  % ѡȡ����ͨ�������Ĵ�����ֵ�������㴫�亯��
t = 1 - 0.95*(Idark./A1);  % ���㴫�亯��
t0=0.1;  % ���亯����ֵ

Recover=zeros(size(OriImage));   % �趨��ԭͼƬ��С

Recover(:,:,1) = ((OriImage(:,:,1) - A(1))./(A(1).*max(t,t0)))+1;     % Rͨ��ȥ��ԭ��ʽ
Recover(:,:,2) = ((OriImage(:,:,2) - A(2))./(A(2).*max(t,t0)))+1;     % Gͨ��ȥ��ԭ��ʽ
Recover(:,:,3) = ((OriImage(:,:,3) - A(3))./(A(3).*max(t,t0)))+1;     % Bͨ��ȥ��ԭ��ʽ

toc; % ��������ʱ��

figure,imshow(OriImage),title('����ͼ��');
%figure,imshow(Idark),title('��ͨ��');
%figure,imshow(t),title('���亯��');
figure,imshow(Recover),title('ȥ����ͼ��');
