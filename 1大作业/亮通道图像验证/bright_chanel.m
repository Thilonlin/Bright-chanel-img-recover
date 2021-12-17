
%%
%图像读取
f1 = imread('E:\大三上课程\数字图像处理\1大作业\亮通道图像验证\验证图片集\1.jfif');%读取原始图像

figure(1),imshow(f1),title('验证图像');

%saveas(1,'.\new_img\task4\原图像添加均匀噪声.jpg');


%%
%获取图像亮通道数值
[h0,w0,d0] = size(f1)




f1 = double(f1);
%[h,w] = size(f1);

filter_size = 9;%设定窗口大小
f_size = (filter_size-1)/2;

imsize = max(h0/filter_size+1,w0/filter_size+1);

f2 = double(f1);
R = f1(:,:,1);%获取三个通道的颜色参数
G = f1(:,:,2);
B = f1(:,:,3);
%[h,w,d] = size(R)
R = imresize(R,[imsize*filter_size imsize*filter_size]);
G = imresize(G,[imsize*filter_size imsize*filter_size]);
B = imresize(B,[imsize*filter_size imsize*filter_size]);
f1 = imresize(f1,[imsize*filter_size imsize*filter_size]);
%temp_R=(R(f_size:1:2*f_size,f_size:1:2*f_size))
%f1 = padarray(f1,[f_size,f_size],'symmetric');%图像边缘进行镜像填充

[h,w] = size(R)%获取填充后图像的长宽

%%
% %对图像进行取最大值处理
for i = 1 :filter_size-1: h-filter_size
    for j = 1 :filter_size-1: w-filter_size
      temp_R=R(i:i+filter_size,j:j+filter_size);
      temp1_R = max(max(temp_R(:)));
      temp_G=G(i:1:i+filter_size,j:1:j+filter_size);
      temp1_G = max(max(temp_G(:)));
      temp_B=B(i:1:i+filter_size,j:1:j+filter_size);
      temp1_B = max(max(temp_B(:)));
      temp1 = max(temp1_R,temp1_G);
      temp1 = max(temp1,temp1_B);
      for i1 = 1:filter_size
          for j1 = 1:filter_size
              f1(i+i1-1,j+j1-1) = temp1;
          end
      end

    end  
end  

f1=uint8(f1);    %转换成unit8进行显示和存储
f1 = rgb2gray(f1);


% 图片输出以及保存
figure(2),imshow(f1);grid on;
title( '图像亮度最大值图像')



