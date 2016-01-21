clc,clear,close all
%ԭʼ ����
x = [0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0];
y = [1.75,2.45,3.81,4.80,7.00,8.60,9.0,1];

a1 = polyfit(x,y,1);  %����һ�����
a2 = polyfit(x,y,2);  %���ж������
a3 = polyfit(x,y,3);  %�����������

%���ɶ���ʽ
x1 = 0.5:0.05:3.0;
y1 = a1(1).*x1 + a1(2);
y2 = a2(1).*x1.*x1 + a2(2).*x1 + a2(3);
y3 = a3(1).*x1.*x1.*x1 + a3(2).*x1.*x1 + a3(3).*x1+a3(4);

%��ͼ
plot(x,y,'*');
hold on
plot(x1,y1,'b--');
hold on
plot(x1,y2,'k');
hold on
plot(x1,y3,'ro--');
%legend('ԭʼ����','һ�����','�������','�������')

%��ӡ����
p1 = polyval(a1,x) %����ʽ��Xλ�õ�ֵ
p2 = polyval(a2,x)
p3 = polyval(a3,x)
v1 = y-p1;              %���׼ֵ�����
v2 = y-p2;
v3 = y-p3;
s1 = norm(v1,'fro') %���㷶����
s2 = norm(v2,'fro')
s3 = norm(v3,'fro')