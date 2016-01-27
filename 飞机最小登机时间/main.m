clc
clear all;
close all;
%采用蒙特卡洛发 生成每一个乘客的座位号 进而计算模型的正确性
%function Customer=planesqueue(DR2,Randmode)
%DR2表示是否需要动态图，1表示有图，0则没有动态图
%Monte(); 完全随机座位Randmode = 1
%Order_Rand(); %顺序型，根据从靠窗到走廊的顺序进行登记顺序安排Randmode = 2
%Ryramid();%根据倒金字塔的方法，越在靠近飞机里面的乘客越优先登录Randmode = 3
%Order2_Rand();%根据座位顺序，从飞机里面到外面Randmode = 4
%Order();% 顺序型从到外，从靠窗到走廊 ，最优方法，但是不可能在实际过程中实现Randmode = 5
%[Ti,ABDTimes]=planesqueue(0,3);
WaitdevtTime.TrunkWaiTime = 7;
WaitdevtTime.FirstAbdTime = 3;
WaitdevtTime.SecondAbdTime = 4;
CalTimes = 50;
%对每一种情况进行30次模拟，记录完成用时。
% for n = 1:5
%     for i = 1:CalTimes
%         [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
%     end
% end
% i = 1:CalTimes;
% hold off
% axis([1 CalTimes,300,600]);
% 
% %绘制曲线  
% %总共用时
% plot(i,AllTime(1,:),'b');
% hold on;
% plot(i,AllTime(2,:),'g');
% plot(i,AllTime(3,:),'r');
% plot(i,AllTime(4,:),'c');
% plot(i,AllTime(5,:),'m');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('The boarding time');
% %等待次数
% figure(2);
% plot(i,WaitTimes(1,:),'b');
% hold on;
% plot(i,WaitTimes(2,:),'g');
% plot(i,WaitTimes(3,:),'r');
% plot(i,WaitTimes(4,:),'c');
% plot(i,WaitTimes(5,:),'m');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('Delay Times');
% 
% %求平均时间
% averageTime = zeros(1,5);
% for n = 1:5
%     for i = 1:CalTimes
%         averageTime(n) = AllTime(n,i) + averageTime(n);
%     end
%     averageTime(n) = int16(averageTime(n)/CalTimes);
% end
% fprintf('平均时间:\nRandom：%3d \nOutside-in：%d\nReversePyramid：%d\nBack-to-front：%d\nOrder：%d \n',averageTime(1),averageTime(2),averageTime(3),averageTime(4),averageTime(5)); 
% 
% averageWaitTime = zeros(1,5);
% for n = 1:5
%     for i = 1:CalTimes
%         averageWaitTime(n) = WaitTimes(n,i) + averageWaitTime(n);
%     end
%     averageWaitTime(n) = int16(averageWaitTime(n)/CalTimes);
% end
% fprintf('\n平均等待次数:\nRandom：%3d \nOutside-in：%d\nReversePyramid：%d\nBack-to-front：%d\nOrder：%d \n',averageWaitTime(1),averageWaitTime(2),averageWaitTime(3),averageWaitTime(4),averageWaitTime(5)); 

%当让位时间逐渐增加，观察所使用时间的变化
% WaitdevtTime.TrunkWaiTime = 20;
% [q,b,c] = planesqueue(0,2,WaitdevtTime);
% q

%当放置行李的时间和让位时间发生变化的时候，登机总的时间发生的变化图
% x = 0;
% for k = 1:15
%     WaitdevtTime.FirstAbdTime = k;
%     WaitdevtTime.SecondAbdTime = k;
%     k
%     for n = 1:5
%         for i = 1:CalTimes
%             [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
%             x = x + AllTime(n,i);
%         end
%         aaa(n,k) = x / CalTimes;
%         x = 0;
%     end 
% end
% i = 1:15;
% hold off
% axis([1 15,300,600]);
% plot(i,aaa(1,:),'b');
% hold on;
% plot(i,aaa(2,:),'g');
% plot(i,aaa(3,:),'r');
% plot(i,aaa(4,:),'c');
% plot(i,aaa(5,:),'m');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('The boarding time');
% xlabel('Abdicate Time/Δt');
% ylabel('The boarding time/Δt')

% 
% %无行李时的登机时间和等待次数
% WaitdevtTime.TrunkWaiTime = 1;
% for n = 1:5
%     for i = 1:30
%         [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
%     end
% end
% 
% %绘制曲线  
% %总共用时
% figure(3);
% i = 1:30;
% hold off
% axis([1 30,300,600]);
% plot(i,AllTime(1,:),'b>-');
% hold on;
% plot(i,AllTime(2,:),'go-');
% plot(i,AllTime(3,:),'rx-');
% plot(i,AllTime(4,:),'cd-');
% plot(i,AllTime(5,:),'m+-');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('总共用时2');
% %等待次数
% figure(4);
% plot(i,WaitTimes(1,:),'b>-');
% hold on;
% plot(i,WaitTimes(2,:),'go-');
% plot(i,WaitTimes(3,:),'rx-');
% plot(i,WaitTimes(4,:),'cd-');
% plot(i,WaitTimes(5,:),'m+-');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('等待次数2');
% 
% %求平均时间
% averageTime = zeros(1,5);
% for n = 1:5
%     for i = 1:30
%         averageTime(n) = AllTime(n,i) + averageTime(n);
%     end
%     averageTime(n) = int16(averageTime(n)/30);
% end
% fprintf('平均时间2:\nRandom：%3d \nOrder_Rand：%d\nRyramid：%d\nOrder2_Rand：%d\nOrder：%d \n',averageTime(1),averageTime(2),averageTime(3),averageTime(4),averageTime(5)); 
% 
% averageWaitTime = zeros(1,5);
% for n = 1:5
%     for i = 1:30
%         averageWaitTime(n) = WaitTimes(n,i) + averageWaitTime(n);
%     end
%     averageWaitTime(n) = int16(averageWaitTime(n)/30);
% end
% fprintf('\n平均等待次数2:\nRandom：%3d \nOrder_Rand：%d\nRyramid：%d\nOrder2_Rand：%d\nOrder：%d \n',averageWaitTime(1),averageWaitTime(2),averageWaitTime(3),averageWaitTime(4),averageWaitTime(5)); 


%现在已经确定，Outside-in是最优的登进机方法，现在对他在不同放置行李时间的情况下，进行绘制图形
% n = 2;
% for n = 1:5
%     WaitdevtTime.TrunkWaiTime = n * 2;
%     for i = 1:30
%             [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,2,WaitdevtTime);
%          end
%     n
% end

% figure(5);
% i = 1:30;
% hold off
% axis([1 30,300,600]);
% plot(i,AllTime(1,:),'bo-');
% hold on;
% plot(i,AllTime(2,:),'go-');
% plot(i,AllTime(3,:),'ro-');
% plot(i,AllTime(4,:),'co-');
% plot(i,AllTime(5,:),'mo-');
% legend('Trunk2','Trunk4','Trunk6','Trunk8','Trunk10');
% title('总共用时3');
% figure(6);
% plot(i,WaitTimes(1,:),'bo-');
% hold on;
% plot(i,WaitTimes(2,:),'go-');
% plot(i,WaitTimes(3,:),'ro-');
% plot(i,WaitTimes(4,:),'co-');
% plot(i,WaitTimes(5,:),'mo-');
% legend('Trunk2','Trunk4','Trunk6','Trunk8','Trunk10');
% title('等待次数3');


%随机登机模型和outside-in模型相比较，outside-in可以优化多少\
%步进单位s
WaitdevtTime.TrunkWaiTime = 7;
WaitdevtTime.FirstAbdTime = 5;
WaitdevtTime.SecondAbdTime = 6;
% [a,b,c] = planesqueue(0,2,WaitdevtTime);
% a
x = 0;
    for n = 1:2
        for i = 1:CalTimes
            [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
            x = x + AllTime(n,i);
        end
        aaa(n)= x / CalTimes;
        x = 0;
    end 
    
    aaa
    int16(aaa(1))-int16(aaa(2))


