%最初的去雾程序，存在白边现象
clc;
clear all;

tic; % 计算运行时间

I = double( imread('./亮通道受损\14.jpeg'));
OriImage=I./max(I(:));    % 归一化处理


% 功能：获取暗通道图像
%%%%%%%%%%%%%%%%%%%%%%%%%
DarkImage  = max(OriImage,[],3);  % 每一个像素点在三个颜色通道中的最小值，相当于分布中变量的具体的值
Idark=Get_BrightChannel(DarkImage,15); %求取暗通道
%%%%%%%%%%%%%%%%%%%%%%%%%

% 功能：获取大气A的估计
A = airlight(OriImage, Idark); % 计算大气光

% 功能：计算传输函数
A1=max(A(:));  % 选取三个通道中最大的大气光值用来计算传输函数
t = 1-0.1*(1-1.25*(Idark./A1));  % 计算传输函数
t0=0.1;  % 传输函数阈值

Recover=zeros(size(OriImage));   % 设定复原图片大小

Recover(:,:,1) = ((OriImage(:,:,1) + A(1))./max(t,t0))-A(1);     % R通道去雾复原公式
Recover(:,:,2) = ((OriImage(:,:,2) + A(2))./max(t,t0))-A(2);     % G通道去雾复原公式
Recover(:,:,3) = ((OriImage(:,:,3) + A(3))./max(t,t0))-A(3);     % B通道去雾复原公式

toc; % 计算运行时间

figure(1),imshow(OriImage),title('夜景图像');
% figure(2),imshow(Idark),title('亮通道');
% figure(3),imshow(t),title('传输函数');
figure(4),imshow(Recover),title('复原后的图像');
saveas(4,'.\亮通道受损\recover\14.jpg')
