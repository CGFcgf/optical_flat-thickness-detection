function out = Describe_edge( ed )
%%
[B,L] = bwboundaries(ed,'noholes');%Ѱ�ұ�Ե����������
out=label2rgb(L, @jet, [.5 .5 .5]);
% subplot(133);
% imshow(label2rgb(L, @jet, [.5 .5 .5]))%��ʾͼ��
figure;
imshow(out);
title('���');
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
end%����ѭ����ʾ�������

% gfframe=getframe(gcf);
% gffim=frame2im(gfframe);
% imwrite(gffim,'image.jpg')
end

