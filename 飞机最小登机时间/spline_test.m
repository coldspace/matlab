function spline_test(X,Y)
%CS��һ���ṹ�壬���е�ֵ�ǣ�
% form: ������������
%     pp Ϊ�ֶζ���ʽ����
% breaks: �ֶ�����ڵ����
% 
% coefs:  ���ֶ������ϵĲ�ֵ����ʽϵ������
% pieces: �ֶ�����
% order:  ��ʽ����
% dim : ����ά��
cs = spline(X,Y);   %������������
fnplt(cs);
hold on
plot(X,Y,'o')
legend('cubic spline','data')
hold off