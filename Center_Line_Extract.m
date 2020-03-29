function ln = Center_Line_Extract( fo )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
binaryImage = ~fo;
 
% Skeletonize
skeletonizedImage = bwmorph(binaryImage, 'skel', inf);
% distance transform.
Dist_Img = bwdist(~binaryImage);
% multiply
CenLine_Img = Dist_Img .* single(skeletonizedImage);
% binarize
T_level = 0.65;
CenLine_Img = uint8(255*im2bw(CenLine_Img, T_level));
 
% display
% figure;
% subplot(131);
% imshow(skeletonizedImage, []);
% % figure;
% subplot(132);
% imshow(Dist_Img, []);
% % figure;
% subplot(133);
% imshow(CenLine_Img);
 
% C = unique(CenLine_Img);
% fo1=fo;
% fo2=uint8(fo1);
% [m1,n1]=size(fo2);
% for i=1:m1
%     for j=1:n1
%         fo3(i,j)=fo2(i,j)+CenLine_Img(i,j);
%         if(fo3(i,j)>=1)
%             fo3(i,j)=1;
%         end
%     end
% end
% I=CenLine_Img+fo;
ln=logical(CenLine_Img );

end

