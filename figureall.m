temphh = [489.69 	349.29 	140.40 	1.27	1467.00 
349.46 	234.51 	114.55 	1.2	1205.90 
415.86 	295.85 	120.01 	1.65	1270.21 
199.78 	109.56 	90.22 	1.86	893.28 
387.11 	280.19 	106.93 	1.98	1211.00 
328.71 	228.96 	99.75 	3.15	1115.00 
284.95 	173.80 	111.16 	3.33	1079.94 
309.12 	199.08 	110.04 	4.01	1090.89 
347.61 	237.49 	110.12 	7.38	1171.77 
274.08 	182.17 	91.90 	6.41	1019.66 
291.70 	191.07 	100.64 	6.15	1078.07 
];
temphh = temphh';
x = 2003:2013;
hold on;
plot(x,temphh(1,:),'b.-');
plot(x,temphh(2,:),'go-');
plot(x,temphh(3,:),'rx-');
plot(x,temphh(4,:),'c+-');
plot(x,temphh(5,:),'m*-');
axis([2003 2013 0 1500]);
xlabel( 'Year' );
ylabel( 'Water resources / hundred million m3' );
title('Water resources and Rainfall')
legend( 'Overall water resource','Surface water resource' ,'Underground water resource','Other water resource','Precipitation');
grid on;