clc
clear all
close all

load C.mat
load lookup.mat  %6 slice images
f=48;
sn=2;
tmp_i=C(:,:,1);
[eny enx]=size(tmp_i);


cindex=1:36;
cindex=reshape(cindex,6,6);
cindex=cindex';
cindex=repmat(cindex,1,sn);  % cindex=repmat(cindex,1,sn);

idx1=1:eny;
idx2=1:enx;

shx=round(enx*f/470);
shy=shx;
sub_slice=zeros(eny+shy*5, enx+shx*5, 36*sn); %size of first depth image
tic
for i=1:sn   % number of slice image  % for i=1:sn 
   for j=(36*(i-1)+1):(36*(i-1)+36)  % reconstrut sub_slice image
          sub_slice(lookup(j,1)+idx1,lookup(j,2)+idx2,j)=C(:,:,cindex(j));
   end
end
T1=toc;


clear C
clear lookup

%index=1:36*sn;
index=1:36*sn;
index=reshape(index,36,sn); %index=reshape(index,36,sn);
index=index';
re_sub_slice=[];
tic
for i=1:sn
    re_sub_slice=[re_sub_slice sub_slice(:,:,index(i,:))]; 
end
T2=toc;
clear sub_slice
re_sub_size_x=size(re_sub_slice,1);
re_sub_size_y=size(re_sub_slice,2);

%total_size=sub_size_x*sub_size_y;
focus=zeros(re_sub_size_x,re_sub_size_y);
slice_image=zeros(re_sub_size_x,re_sub_size_y);
tic
for i=1:re_sub_size_x
    for j=1:re_sub_size_y
        temp=re_sub_slice(i,j,:);
        index=temp~=0;
        temp2=temp(index);
        
        temp_mean=mean(temp2(:));
        temp_std=std(temp2(:));
        
        slice_image(i,j)=temp_mean;

         if(temp_std>12||temp_mean<70)
            focus(i,j)=0;
        else 
            focus(i,j)=temp_mean;
        end
    end
end
T3=toc;
T=T1+T2+T3;

figure(2)
colormap(gray(256)), imagesc(focus)

figure(3)
colormap(gray(256)), imagesc(slice_image)
%=========================================================================