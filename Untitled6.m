% clear
% p1=[1.24,1.27;1.36,1.74;1.38,1.64;1.38,1.82;1.38,1.90;
% 1.40,1.70;1.48,1.82;1.54,1.82;1.56,2.08];
% p2=[1.14,1.82;1.18,1.96;1.20,1.86;1.26,2.00
% 1.28,2.00;1.30,1.96];
% p=[p1;p2]';
% pr=minmax(p);
% goal=[ones(1,9),zeros(1,6);zeros(1,9),ones(1,6)];
% net = newlvq(pr,4,[0.6,0.4]);
% net = train(net,p,goal);
% x=[1.24 1.80;1.28 1.84;1.24 1.27]';
% sim(net,x)
% sim(net,p)

clear
% p1=[1.24,1.27;1.36,1.74;1.38,1.64;1.38,1.82;1.38,1.90;
% 1.40,1.70;1.48,1.82;1.54,1.82;1.56,2.08];
% p2=[1.14,1.82;1.18,1.96;1.20,1.86;1.26,2.00
% 1.28,2.00;1.30,1.96];
%p1 = [9125	1480.67	6485.05	4112.43;9180 1778.45	8478.69	4764.70;9248	1963.51	10478.62	5924.74;9309	2138.90	12574.03	7187.26;9367	2509.14	14647.53	8620.24;9417	3002.65	17571.98	10358.64;9470	3226.64	18901.83	11768.18;9579	3588.28	21238.49	14343.14];
p1 = [1480.67	6485.05	4112.43;
1778.45	8478.69	4764.70;
1963.51	10478.62	5924.74;
2138.90	12574.03	7187.26;
2509.14	14647.53	8620.24;
3002.65	17571.98	10358.64;
3226.64	18901.83	11768.18;
3588.28	21238.49	14343.14];
p=[p1]';
pr=minmax(p);
% goal=[ones(1,9),zeros(1,6);zeros(1,9),ones(1,6)];
goal = [215.80 211.30 207.65 222.24 219.55 219.89 220.01 222.47 224.04 221.80 217.95];
%goal = goal';
net=newff(pr,goal,3,{'tansig' 'tansig'});
net.trainParam.show = 10;
net.trainParam.lr = 0.0001;
net.trainParam.goal = 1e-10;
net.trainParam.epochs = 50000;
net = train(net,p,goal);
% x=[9637	3973.85	24017.11	17370.89;9685	4281.70	25735.73	19995.81;9733	4742.63	27422.47	22519.23]';
x = [154.26	29.72	32.89	7.17;
154.23	28.10	32.81	6.66;
149.72	28.86	33.31	6.06]';
y0=sim(net,p)
y=sim(net,x)