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
X =[ 0,0.2,0.4,0.6,0.8,1.0,1.2];
Y=[1.0, 0.1, 0.3, 0.548812, 0.1, 0.5,0.9];
cs = spline(X,Y);   %������������
fnplt(cs);
hold on
plot(X,Y,'o')
legend('cubic spline','data')
hold off