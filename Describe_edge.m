function out = Describe_edge( ed )
%%
[B,L] = bwboundaries(ed,'noholes');%寻找边缘，不包括孔
out=label2rgb(L, @jet, [.5 .5 .5]);
% subplot(133);
% imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像
figure;
imshow(out);
title('描边');
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1)
end%整个循环表示的是描边

% gfframe=getframe(gcf);
% gffim=frame2im(gfframe);
% imwrite(gffim,'image.jpg')
end

