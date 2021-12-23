%���ø���֪ʶ�Ľ���ȥ����
clc;
clear all;

tic; % ��������ʱ��

%��ʼ������
r=41;
eps=0.01;

I = double( imread('./1Ч���õ�ͼ/12.jpeg'));

OriImage=I./max(I(:));    % ��һ������


% ���ܣ���ȡ��ͨ��ͼ��
% guidedfilter�������ø�ʽ��  ��� = guidedfilter�����룬���룬r,eps��;r��eps�Ѹ���

%%%%%%%%%%%%%%%%%%%%%%%%%
DarkImage  = max(OriImage,[],3);  % ÿһ�����ص���������ɫͨ���е���Сֵ���൱�ڷֲ��б����ľ����ֵ

DarkImage_ave_local = guidedfilter(DarkImage,DarkImage , r, eps);% �����Ե��Ϣ�ľ�ֵ

a1 = (DarkImage-DarkImage_ave_local).^2; % ����

DarkImage_std_local = guidedfilter(DarkImage,a1, r, eps); % �����Ե��Ϣ�ķ���

Imin = DarkImage_ave_local-max(3.*DarkImage_std_local,0.001); % ���㰵ͨ��

Idark=max(Imin,DarkImage); % ��ֵ����
%%%%%%%%%%%%%%%%%%%%%%%%%

% ���ܣ���ȡ����A�Ĺ���
A = airlight(OriImage, Idark); % ���������

% ���ܣ����㴫�亯��
A1=max(A(:));  % ѡȡ����ͨ�������Ĵ�����ֵ�������㴫�亯��
t = 1-0.25*(1-1.15*(Idark./A1)); % ���㴫�亯��
t0=0.1;  % ���亯����ֵ

Recover=zeros(size(OriImage));   % �趨��ԭͼƬ��С

Recover(:,:,1) = ((OriImage(:,:,1) + A(1))./(A(1).*max(t,t0)))-1;     % Rͨ��ȥ��ԭ��ʽ
Recover(:,:,2) = ((OriImage(:,:,2) + A(2))./(A(2).*max(t,t0)))-1;     % Gͨ��ȥ��ԭ��ʽ
Recover(:,:,3) = ((OriImage(:,:,3) + A(3))./(A(3).*max(t,t0)))-1;     % Bͨ��ȥ��ԭ��ʽ

toc; % ��������ʱ��

figure(1),imshow(OriImage),title('�谵ͼ��');
%figure(2),imshow(Idark),title('��ͨ��');
%figure(3),imshow(t),title('���亯��');
figure(4),imshow(Recover),title('��ͨ�����黹ԭ��ͼ��');
saveas(4,'./1Ч���õ�ͼ/recover/4.jpg')
