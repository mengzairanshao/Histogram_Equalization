clc,clear,close all;
originalPic=imread('pout.tif');%读取图像,pout.tif是matlab自带图像
[M,N]=size(originalPic);       %获取图像尺寸
pixelValueStat=zeros(1,256);               %
pixelValueCumsumStat=zeros(1,256);
resultPixelValueStat=zeros(1,256);
resultPic=originalPic;
subplot(3,2,1),imshow(originalPic),title('原图像');
for i=1:M
    for j=1:N
        pixelValueStat(originalPic(i,j))=pixelValueStat(originalPic(i,j))+1;
    end
end
subplot(3,2,3),imhist(originalPic),title('原始图像直方图');
for i=1:256
    for j=1:i
        pixelValueCumsumStat(i)=pixelValueCumsumStat(i)+pixelValueStat(j);
    end
end
pixelValueCumsumFreStat=pixelValueCumsumStat/(M*N);
hh=round(255*pixelValueCumsumFreStat+0.5);

for i=1:M
    for j=1:N
        resultPic(i,j)=hh(resultPic(i,j)+1);
    end
end

for i=1:M
    for j=1:N
        resultPixelValueStat(resultPic(i,j))=resultPixelValueStat(resultPic(i,j))+1;
    end
end
subplot(3,2,2),imshow(resultPic),title('直方图均衡化后的图像');
subplot(3,2,4),imhist(resultPic),title('直方图均衡化后的图像直方图');
x=0:255;
subplot(3,2,5),stem(x,pixelValueStat/(M*N),'.'),title('原始图像各像素值在图像中所占比例'),xlabel('像素值'),ylabel('在图像中所占比例');
subplot(3,2,6),stem(x,resultPixelValueStat/(M*N),'.'),title('直方图均衡化后的图像各像素值在图像中所占比例'),xlabel('像素值'),ylabel('在图像中所占比例');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);
saveas(gcf,strcat(mfilename,'_pic'),'jpg');