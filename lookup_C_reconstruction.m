% lookup and C matrix reconstruction
clc
clear all
close all

f=18;
tmp_i=double(imread(['D:\Master Thesis\segmentation\multiple_depth_image\multiple_depth_image\sixbysix\', num2str(1), '.jpg']));
tmp_i=mosaic(imresize(tmp_i,0.15));
[v h]=size(tmp_i);
enx=h;
eny=v;
C=zeros(v,h,36);
for k=1:36
    tmp_ii=rgb2gray(imread(['D:\Master Thesis\segmentation\multiple_depth_image\multiple_depth_image\sixbysix\', num2str(k), '.jpg']));
    tmp_ii=imresize(tmp_ii,0.15);
    C(:,:,k)=single(tmp_ii);
end
C=single(C);


% for i=1:1
%     shx=round(enx*f/820);
%     shy=shx;
%     row=0;
%     for x=1:6
%         for y=1:6
%             shx2=shy*(x-1);
%             shy2=shx*(y-1);
%             row=row+1;
%             lookup(row+36*(i-1),1)=shx2;
%             lookup(row+36*(i-1),2)=shy2;
%         end
%     end
% end