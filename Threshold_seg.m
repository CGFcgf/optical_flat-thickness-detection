function out = Threshold_seg( xx,radius )
%Threshold_seg( xx,radius )函数，一个自定义阈值分割函数
% 针对明暗度不同的感兴趣区域，将其划分开分别进行阈值分割
% xx是图像，radius是圆形感兴趣区域的半径

dimention=2*radius;   %直径
x1=zeros(radius,dimention);
for i=1:radius
    for j=1:dimention
        x1(i,j)=xx(i,j);
    end
end
% figure;
% subplot(231);
% imshow(x1);
% title('上半部分灰度图');

x2=zeros(radius,dimention);
for i=1:radius
    for j=1:dimention
        x2(i,j)=xx(i+radius,j);
    end
end
% subplot(234);
% imshow(x2);
% title('下半部分灰度图');
%%
% 
%  阈值分割
% 
I1=im2uint8(x1);  %把图像数据转为uint8类型 
I2=im2uint8(x2);
% I1=uint8(round(x1*255)); 
% figure;
% subplot(232);
% imhist(I1);
% title('上半部分灰度直方图');
% subplot(235);
% imhist(I2);
% title('下半部分灰度直方图');

[width,height]=size(I1);
Image1=I1;
T1=140;     %手动设定一个转换阈值
for i=1:width
    for j=1:height
        if(I1(i,j)<T1)
            Image1(i,j)=0;
        else 
            Image1(i,j)=1;
        end
    end
end
Image1=logical(uint8(round(Image1)));
% subplot(233);
% imshow(Image1),title('上半部分人工阈值进行分割');

[width,height]=size(I2);
Image2=I2;
T2=140;
for i=1:width
    for j=1:height
        if(I2(i,j)<T2)
            Image2(i,j)=0;
        else 
            Image2(i,j)=1;
        end
    end
end
Image2=logical(uint8(round(Image2)));
% subplot(236);
% imshow(Image2),title('下半部分人工阈值进行分割');

M=zeros(dimention,dimention);
for i=1:radius
    for j=1:dimention
        M(i,j)=Image1(i,j);
    end
end

for i=1:radius
    for j=1:dimention
        M(i+radius,j)=Image2(i,j);
    end
end
out=M;
% figure;
% subplot(131);
% imshow(M);
% title('阈值分割');

end

