%利用概率知识改进的去雾方法
clc;
clear all;

tic; % 计算运行时间

%初始化参数
r=41;
eps=0.01;

I = double( imread('./有雾图/dark_road.jpg'));
OriImage=I./max(I(:));    % 归一化处理


% 功能：获取暗通道图像
% guidedfilter函数调用格式：  输出 = guidedfilter（输入，输入，r,eps）;r和eps已给出

%%%%%%%%%%%%%%%%%%%%%%%%%
DarkImage  = max(OriImage,[],3);  % 每一个像素点在三个颜色通道中的最小值，相当于分布中变量的具体的值min

DarkImage_ave_local = guidedfilter(DarkImage,DarkImage , r, eps);% 保存边缘信息的均值

a1 = (DarkImage-DarkImage_ave_local).^2; % 方差

DarkImage_std_local = guidedfilter(DarkImage,a1, r, eps); % 保存边缘信息的方差

Imin = DarkImage_ave_local-max(3.*DarkImage_std_local,0.001); % 计算暗通道min

Idark=max(Imin,DarkImage); % 阈值处理min
%%%%%%%%%%%%%%%%%%%%%%%%%

% 功能：获取大气A的估计
A = airlight(OriImage, Idark); % 计算大气光

% 功能：计算传输函数
A1=max(A(:));  % 选取三个通道中最大的大气光值用来计算传输函数max
t = 1 - 0.95*(Idark./A1);  % 计算传输函数
t0=0.1;  % 传输函数阈值

Recover=zeros(size(OriImage));   % 设定复原图片大小

Recover(:,:,1) = ((OriImage(:,:,1) - A(1))./(A(1).*max(t,t0)))+1;     % R通道去雾复原公式
Recover(:,:,2) = ((OriImage(:,:,2) - A(2))./(A(2).*max(t,t0)))+1;     % G通道去雾复原公式
Recover(:,:,3) = ((OriImage(:,:,3) - A(3))./(A(3).*max(t,t0)))+1;     % B通道去雾复原公式

toc; % 计算运行时间

figure,imshow(OriImage),title('雾天图像');
figure,imshow(Idark),title('暗通道');
figure,imshow(t),title('传输函数');
figure,imshow(Recover),title('去雾后的图像');