clc,clear,close all;
originalPic=imread('pout.tif');     %读取图像,pout.tif是matlab自带图像
[M,N]=size(originalPic);            %获取图像尺寸
pixelValueStat=zeros(1,256);        %原始图像像素值统计
pixelValueCumsumStat=zeros(1,256);  %原始图像像素值累加统计
resultPixelValueStat=zeros(1,256);  %直方图均衡化后图像像素值统计
resultPic=originalPic;              %直方图均衡化后图像
subplot(3,2,1),imshow(originalPic),title('原图像');
%进行原始图像像素值统计
for i=1:M
    for j=1:N
        pixelValueStat(originalPic(i,j))=pixelValueStat(originalPic(i,j))+1;
    end
end
subplot(3,2,3),imhist(originalPic),title('原始图像直方图');
%进行原始图像像素值累加统计
for i=1:256
    for j=1:i
        pixelValueCumsumStat(i)=pixelValueCumsumStat(i)+pixelValueStat(j);
    end
end
pixelValueCumsumFreStat=pixelValueCumsumStat/(M*N);%原始图像像素值频率统计
hh=round(255*pixelValueCumsumFreStat+0.5);         %频率统计*255,进行四舍五入

for i=1:M
    for j=1:N
        resultPic(i,j)=hh(resultPic(i,j)+1);       %将原始图像中对应像素进行替换
    end
end

%对直方图均衡化后的图像进行统计
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
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);%[0,0,1.0,1.0]表示左下角为原点,长和宽分别占屏幕的100%
saveas(gcf,strcat(mfilename,'_pic'),'jpg');           %以文件名加'_pic'为名保存文件