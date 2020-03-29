function out = Circle_Region_seg( bw )
% 提取感兴趣区域
% 发现图中的面积在250——300之间的圆形子区域
[c,r]=imfindcircles(bw,[250 300],'ObjectPolarity','dark','Sensitivity',.97);
figure;
subplot(131);
imshow(bw);
% 在原图中标记圆心为c半径为r的圆形区域
viscircles(c,r);
title('检测圆');

%提取圆形区域
ln=Circle_Region_Extract(bw,r,c);
subplot(132);
imshow(ln);
title('提取圆形区域')

% dimention = 540;
% radius = 270;
radius=ceil(r);      %半径
dimention=2*radius;  
xx = zeros(dimention, dimention);
center_x = round(size(xx,1)/2); %xx的中心点坐标
center_y = round(size(xx,2)/2);
center_x1=floor(c(1,2));   %原图圆心坐标
center_y1=floor(c(1,1));
for i = 1: size(xx, 1)
    for j = 1: size(xx,2)
        temp = sqrt((i-center_x)^2+(j-center_y)^2);
        if(temp <= radius)
            xx(i, j) = ln(center_x1-radius+i+1,center_y1-radius+j+1);
        end
    end
end
% figure;
out=xx;
subplot(133);
imshow(out);
title('分割出来感兴趣区域');

end

