function spline_test(X,Y)
%CS是一个结构体，其中的值是：
% form: 样条函数类型
%     pp 为分段多项式样条
% breaks: 分段区间节点矩阵
% 
% coefs:  各分段区间上的插值多项式系数矩阵，
% pieces: 分段数，
% order:  项式阶数
% dim : 矩阵维数
cs = spline(X,Y);   %三次样条函数
fnplt(cs);
hold on
plot(X,Y,'o')
legend('cubic spline','data')
hold off