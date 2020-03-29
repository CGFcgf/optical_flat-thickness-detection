function out = Circle_Region_seg( bw )
% ��ȡ����Ȥ����
% ����ͼ�е������250����300֮���Բ��������
[c,r]=imfindcircles(bw,[250 300],'ObjectPolarity','dark','Sensitivity',.97);
figure;
subplot(131);
imshow(bw);
% ��ԭͼ�б��Բ��Ϊc�뾶Ϊr��Բ������
viscircles(c,r);
title('���Բ');

%��ȡԲ������
ln=Circle_Region_Extract(bw,r,c);
subplot(132);
imshow(ln);
title('��ȡԲ������')

% dimention = 540;
% radius = 270;
radius=ceil(r);      %�뾶
dimention=2*radius;  
xx = zeros(dimention, dimention);
center_x = round(size(xx,1)/2); %xx�����ĵ�����
center_y = round(size(xx,2)/2);
center_x1=floor(c(1,2));   %ԭͼԲ������
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
title('�ָ��������Ȥ����');

end

