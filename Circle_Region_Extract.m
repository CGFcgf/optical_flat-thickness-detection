function ln=Circle_Region_Extract(Image,Radius,Center)
if ~(abs(Center(1)-Radius)<0 & abs(Center(2)-Radius)<0)
    [m,n,z]=size(Image);
    [X,Y]=meshgrid(1:n,1:m);
    R_temp=sqrt((X-Center(1)).^2+(Y-Center(2)).^2);
    R_temp1=R_temp<=Radius;
    if(numel(size(Image))>2)
        R_Out=R_temp1.*im2double(Image(:,:,1));
        G_Out=R_temp1.*im2double(Image(:,:,2));
        B_Out=R_temp1.*im2double(Image(:,:,3));
        ln(:,:,1)=R_Out;
        ln(:,:,2)=G_Out;
        ln(:,:,3)=B_Out;
    else
        ln=R_temp1.*im2double(Image);
    end
else
    disp('exceed Radius');
end
% imshow(ln);