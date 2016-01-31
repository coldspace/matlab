function spline_test()
clc
clear all;
close all;
%CS��һ���ṹ�壬���е�ֵ�ǣ�
% form: ������������
%     pp Ϊ�ֶζ���ʽ����
% breaks: �ֶ�����ڵ����
% 
% coefs:  ���ֶ������ϵĲ�ֵ����ʽϵ������
% pieces: �ֶ�����
% order:  ��ʽ����
% dim : ����ά��
% X =[ 0,0.2,0.4,0.6,0.8,1.0,1.2];
% Y=[1.0, 0.1, 0.3, 0.548812, 0.1, 0.5,0.9];
X = 2003:2013
Y = [936.3	769.7	810.7	570.1 773	711.8	689.3	696.3	747.9	650.8	672];
cs = spline_(X,Y);   %������������
fnplt(cs);
% cs = polyfit(X,Y,2);
% y1 = polyval(cs,2003:0.1:2013);
% plot(2003:0.1:2013,y1,'r*-');
hold on
plot(X,Y,'o')
legend('cubic spline','data')
hold off


x=[0.25,0.5,1,1.5,2,3,4,6,8];
y=[19.21,18.15,15.36,14.10,12.98,9.32,7.45,5.24,3.01];
[a,res]=lsqcurvefit('myfun',[1,1],x,y);

function F=myfun(a,x) 
F=a(1)+exp(a(2)*x);
end