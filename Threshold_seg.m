function out = Threshold_seg( xx,radius )
%Threshold_seg( xx,radius )������һ���Զ�����ֵ�ָ��
% ��������Ȳ�ͬ�ĸ���Ȥ���򣬽��仮�ֿ��ֱ������ֵ�ָ�
% xx��ͼ��radius��Բ�θ���Ȥ����İ뾶

dimention=2*radius;   %ֱ��
x1=zeros(radius,dimention);
for i=1:radius
    for j=1:dimention
        x1(i,j)=xx(i,j);
    end
end
% figure;
% subplot(231);
% imshow(x1);
% title('�ϰ벿�ֻҶ�ͼ');

x2=zeros(radius,dimention);
for i=1:radius
    for j=1:dimention
        x2(i,j)=xx(i+radius,j);
    end
end
% subplot(234);
% imshow(x2);
% title('�°벿�ֻҶ�ͼ');
%%
% 
%  ��ֵ�ָ�
% 
I1=im2uint8(x1);  %��ͼ������תΪuint8���� 
I2=im2uint8(x2);
% I1=uint8(round(x1*255)); 
% figure;
% subplot(232);
% imhist(I1);
% title('�ϰ벿�ֻҶ�ֱ��ͼ');
% subplot(235);
% imhist(I2);
% title('�°벿�ֻҶ�ֱ��ͼ');

[width,height]=size(I1);
Image1=I1;
T1=140;     %�ֶ��趨һ��ת����ֵ
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
% imshow(Image1),title('�ϰ벿���˹���ֵ���зָ�');

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
% imshow(Image2),title('�°벿���˹���ֵ���зָ�');

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
% title('��ֵ�ָ�');

end

