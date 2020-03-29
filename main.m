close all
clc
clear;
%%
% 读取图像
[filename, pathname] = uigetfile('*.jpg', '读取图片文件'); %选择图片文件
pathfile=fullfile(pathname, filename);  %获得图片路径
rgb=imread(pathfile); 
rgb=imresize(rgb,[720,960]);
[m,n,z]=size(rgb);
% 灰度转换
if(z>2)
    bw=rgb2gray(rgb);
end
%%
% 提取感兴趣区域
xx = Circle_Region_seg( bw );
% [c,r]=imfindcircles(xx,[100 300],'ObjectPolarity','dark','Sensitivity',.97);
% R=ceil(r);
% x1=floor(c(1,2));   %原图圆心坐标
% y1=floor(c(1,1));
%%
%  阈值分割
[m,n]=size(xx);
radius=m/2;
dimention=m;
M=Threshold_seg( xx,radius );

%%
% 
%  形态学处理
%
% se=strel('square',5');%方型结构元素
se=strel('disk',9');%圆盘型结构元素
fc=imclose(M,se);%直接闭运算
fo=imopen(fc,se);%直接开运算

%%
% 
%  条纹中心线提取
% 
fo4=Center_Line_Extract( fo );
[m,n]=size(fo4);
%去除不属于条纹中心线的部分
for i=1:m
    for j=1:n
        if(sqrt((i-m/2)^2+(j-n/2)^2)>m/2)
            fo4(i,j)=0;
        elseif(sqrt((i-m/2)^2+(j-n/2)^2)==m/2)
            fo4(i,j)=1;
        end
    end
end
fo5=fo4;

%%
% canny边缘检测
ed = edge(fo5, 'canny',[0.002,0.02],1); 
axis on;
axis xy;
axis([0 dimention 0 dimention]);
set(gca,'Xtick',0:50:dimention,'Ytick',0:50:dimention);
%%
% 
%  画同心圆
% 
set(gcf,'color','white');
A=ed;
% figure;
% imshow(~A);

for i=1:dimention
    if(sum(A(:,i))~=0)
        a=i;
        break;
    end
end
for i=1:dimention
    if(sum(A(i,:))~=0)
        b=i;
        break;
    end
end
c=ceil((a+b)/4);
Describe_edge( A );
Circle( round(size(A,1)/2),round(size(A,2)/2),radius-c ); %画圆
Circle( round(size(A,1)/2),round(size(A,2)/2),radius-20*c ); %画圆
Circle( round(size(A,1)/2),round(size(A,2)/2),radius-50*c ); %画圆

gfframe=getframe(gcf);
gffim=frame2im(gfframe);
imwrite(gffim,'image0.jpg');
%%
% 
%  图像校正
% 
% 采用ginput函数取点，选好点后回车
[x1,y1] =ginput(n);
k1=size(x1);
axis on
hold on
for i1=1:k1
    plot(x1(i1),y1(i1),'r+');
    text(x1(i1),y1(i1),sprintf('(%f,%f)',x1(i1),y1(i1)));
end  
axis off

% 求两个向量间的夹角
l=sqrt((x1(1)-x1(2))^2+(y1(1)-y1(2))^2);
x12=x1(1);
y12=y1(1);
x13=x1(2);
y13=y1(2);
x14=x13;
% y4=ceil(y3-l);
y14=y12;
N1=[abs(x12-x13),abs(y12-y13)];
N2=[abs(x14-x13),abs(y14-y13)];
NL=sqrt(dot(N1,N1));
ML=sqrt(dot(N2,N2));
LL=dot(N1,N2);
A1=LL/(NL*ML);
O=acosd(A1);

m1=size(x1);
n1=size(y1);
x1=x1';
y1=y1';
hold on;
values1 = spcrv([[x1(1) x1 x1(end)];[y1(1) y1 y1(end)]],3);
plot(values1(1,:),values1(2,:), 'g');
%保存操作后的图像
gfframe=getframe(gcf);
gffim=frame2im(gfframe);
imwrite(gffim,'image1.jpg');
%进行角度校正
G=imread('image0.jpg');
if(x1(1)>x1(2))
    IL = imrotate(G, O, 'crop');
else
    IL = imrotate(G, -O, 'crop');
end
figure;
imshow(IL); 
[m2,n2,z2]=size(IL)
%%
% 
%  取点画线
% 
[x2,y2]=ginput(n);
x21=x2;
y21=n2;
x2=[x2,x21];
y2=[y2,y21];
[j2,k2]=size(x2);
axis on
hold on
for i2=1:k2
    plot(x2(i2),y2(i2),'r+');
    text(x2(i2),y2(i2),sprintf('(%f,%f)',x2(i2),y2(i2)));
end  
axis off

hold on;
values2 = spcrv([[x2(1) x2 x2(end)];[y2(1) y2 y2(end)]],3);
plot(values2(1,:),values2(2,:), 'g');

% [x3,y3]=ginput(n);
x3=x2(1);
y3=y2(1);
x31=0;
y31=y3;
x3=[x3,x31];
y3=[y3,y31];
[j3,k3]=size(x3);
axis on
hold on
for i3=1:k3
    plot(x3(i3),y3(i3),'r+');
    text(x3(i3),y3(i3),sprintf('(%f,%f)',x3(i3),y3(i3)));
end  
axis off

hold on;
values3 = spcrv([[x3(1) x3 x3(end)];[y3(1) y3 y3(end)]],3);
plot(values3(1,:),values3(2,:), 'g');

[x4,y4]=ginput(n);
x41=x4;
y41=n2;
x4=[x4,x41];
y4=[y4,y41];
[j4,k4]=size(x4);
axis on
hold on
for i4=1:k4
    plot(x4(i4),y4(i4),'r+');
    text(x4(i4),y4(i4),sprintf('(%f,%f)',x4(i4),y4(i4)));
end  
axis off

hold on;
values4 = spcrv([[x4(1) x4 x4(end)];[y4(1) y4 y4(end)]],3);
plot(values4(1,:),values4(2,:), 'g');

[x5,y5]=ginput(n);
x51=x5;
y51=n2;
x5=[x5,x51];
y5=[y5,y51];
[j5,k5]=size(x5);
axis on
hold on
for i5=1:k5
    plot(x5(i5),y5(i5),'r+');
    text(x5(i5),y5(i5),sprintf('(%f,%f)',x5(i5),y5(i5)));
end  
axis off

hold on;
values5 = spcrv([[x5(1) x5 x5(end)];[y5(1) y5 y5(end)]],3);
plot(values5(1,:),values5(2,:), 'g');


[x6,y6]=ginput(n);
x61=x6;
y61=n2;
x62=x6;
y62=0;
x6=[x6,x61,x62];
y6=[y6,y61,y62];
[j6,k6]=size(x6);
axis on
hold on
for i6=1:k6
    plot(x6(i6),y6(i6),'r+');
    text(x6(i6),y6(i6),sprintf('(%f,%f)',x6(i6),y6(i6)));
end  
axis off

hold on;
values6 = spcrv([[x6(1) x6 x6(end)];[y6(1) y6 y6(end)]],3);
plot(values6(1,:),values6(2,:), 'g');

[x7,y7]=ginput(n);
x71=x7;
y71=n2;
x72=x7;
y72=0;
x7=[x7,x71,x72];
y7=[y7,y71,y72];
[j7,k7]=size(x7);
axis on
hold on
for i7=1:k7
    plot(x7(i7),y7(i7),'r+');
    text(x7(i7),y7(i7),sprintf('(%f,%f)',x7(i7),y7(i7)));
end  
axis off

hold on;
values7 = spcrv([[x7(1) x7 x7(end)];[y7(1) y7 y7(end)]],3);
plot(values7(1,:),values7(2,:), 'g');

%保存标记后的图像
gfframe=getframe(gcf);
gffim=frame2im(gfframe);
imwrite(gffim,'image2.jpg');
        