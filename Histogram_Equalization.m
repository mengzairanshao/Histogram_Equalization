clc,clear,close all;
originalPic=imread('pout.tif');     %��ȡͼ��,pout.tif��matlab�Դ�ͼ��
[M,N]=size(originalPic);            %��ȡͼ��ߴ�
pixelValueStat=zeros(1,256);        %ԭʼͼ������ֵͳ��
pixelValueCumsumStat=zeros(1,256);  %ԭʼͼ������ֵ�ۼ�ͳ��
resultPixelValueStat=zeros(1,256);  %ֱ��ͼ���⻯��ͼ������ֵͳ��
resultPic=originalPic;              %ֱ��ͼ���⻯��ͼ��
subplot(3,2,1),imshow(originalPic),title('ԭͼ��');
%����ԭʼͼ������ֵͳ��
for i=1:M
    for j=1:N
        pixelValueStat(originalPic(i,j))=pixelValueStat(originalPic(i,j))+1;
    end
end
subplot(3,2,3),imhist(originalPic),title('ԭʼͼ��ֱ��ͼ');
%����ԭʼͼ������ֵ�ۼ�ͳ��
for i=1:256
    for j=1:i
        pixelValueCumsumStat(i)=pixelValueCumsumStat(i)+pixelValueStat(j);
    end
end
pixelValueCumsumFreStat=pixelValueCumsumStat/(M*N);%ԭʼͼ������ֵƵ��ͳ��
hh=round(255*pixelValueCumsumFreStat+0.5);         %Ƶ��ͳ��*255,������������

for i=1:M
    for j=1:N
        resultPic(i,j)=hh(resultPic(i,j)+1);       %��ԭʼͼ���ж�Ӧ���ؽ����滻
    end
end

%��ֱ��ͼ���⻯���ͼ�����ͳ��
for i=1:M
    for j=1:N
        resultPixelValueStat(resultPic(i,j))=resultPixelValueStat(resultPic(i,j))+1;
    end
end
subplot(3,2,2),imshow(resultPic),title('ֱ��ͼ���⻯���ͼ��');
subplot(3,2,4),imhist(resultPic),title('ֱ��ͼ���⻯���ͼ��ֱ��ͼ');
x=0:255;
subplot(3,2,5),stem(x,pixelValueStat/(M*N),'.'),title('ԭʼͼ�������ֵ��ͼ������ռ����'),xlabel('����ֵ'),ylabel('��ͼ������ռ����');
subplot(3,2,6),stem(x,resultPixelValueStat/(M*N),'.'),title('ֱ��ͼ���⻯���ͼ�������ֵ��ͼ������ռ����'),xlabel('����ֵ'),ylabel('��ͼ������ռ����');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);%[0,0,1.0,1.0]��ʾ���½�Ϊԭ��,���Ϳ�ֱ�ռ��Ļ��100%
saveas(gcf,strcat(mfilename,'_pic'),'jpg');           %���ļ�����'_pic'Ϊ�������ļ�