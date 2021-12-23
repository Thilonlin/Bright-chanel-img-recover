function A = airlight(img_ori,img_DC)


%****---------matrix to line-----------****%
[m,n]=size(img_DC);
img_DC_line=zeros(1,(m*n));
k=1;
for i=1:m
    for j=1:n
        img_DC_line(1,k)=img_DC(i,j);
        k=k+1;
    end
end

img_sort=sort(img_DC_line); %升幂排序

Threhold=img_sort(round((m*n)*0.999)); %统计前0.1%亮像素点中的最小值作为阈值
t=1;
for i = 1 : m
    for j = 1 : n
        if ( img_DC(i,j) >= Threhold )
            temp(t,1) = img_ori(i,j,1);
            temp(t,2) = img_ori(i,j,2);
            temp(t,3) = img_ori(i,j,3);
            t = t + 1;
        end
    end    
end
A = max(temp);%max

