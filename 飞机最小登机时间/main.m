clc
clear all;
close all;
%�������ؿ��巢 ����ÿһ���˿͵���λ�� ��������ģ�͵���ȷ��
%function Customer=planesqueue(DR2,Randmode)
%DR2��ʾ�Ƿ���Ҫ��̬ͼ��1��ʾ��ͼ��0��û�ж�̬ͼ
%Monte(); ��ȫ�����λRandmode = 1
%Order_Rand(); %˳���ͣ����ݴӿ��������ȵ�˳����еǼ�˳����Randmode = 2
%Ryramid();%���ݵ��������ķ�����Խ�ڿ����ɻ�����ĳ˿�Խ���ȵ�¼Randmode = 3
%Order2_Rand();%������λ˳�򣬴ӷɻ����浽����Randmode = 4
%Order();% ˳���ʹӵ��⣬�ӿ��������� �����ŷ��������ǲ�������ʵ�ʹ�����ʵ��Randmode = 5
%[Ti,ABDTimes]=planesqueue(0,3);
WaitdevtTime.TrunkWaiTime = 7;
WaitdevtTime.FirstAbdTime = 3;
WaitdevtTime.SecondAbdTime = 4;
CalTimes = 50;
%��ÿһ���������30��ģ�⣬��¼�����ʱ��
% for n = 1:5
%     for i = 1:CalTimes
%         [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
%     end
% end
% i = 1:CalTimes;
% hold off
% axis([1 CalTimes,300,600]);
% 
% %��������  
% %�ܹ���ʱ
% plot(i,AllTime(1,:),'b');
% hold on;
% plot(i,AllTime(2,:),'g');
% plot(i,AllTime(3,:),'r');
% plot(i,AllTime(4,:),'c');
% plot(i,AllTime(5,:),'m');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('The boarding time');
% %�ȴ�����
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
% %��ƽ��ʱ��
% averageTime = zeros(1,5);
% for n = 1:5
%     for i = 1:CalTimes
%         averageTime(n) = AllTime(n,i) + averageTime(n);
%     end
%     averageTime(n) = int16(averageTime(n)/CalTimes);
% end
% fprintf('ƽ��ʱ��:\nRandom��%3d \nOutside-in��%d\nReversePyramid��%d\nBack-to-front��%d\nOrder��%d \n',averageTime(1),averageTime(2),averageTime(3),averageTime(4),averageTime(5)); 
% 
% averageWaitTime = zeros(1,5);
% for n = 1:5
%     for i = 1:CalTimes
%         averageWaitTime(n) = WaitTimes(n,i) + averageWaitTime(n);
%     end
%     averageWaitTime(n) = int16(averageWaitTime(n)/CalTimes);
% end
% fprintf('\nƽ���ȴ�����:\nRandom��%3d \nOutside-in��%d\nReversePyramid��%d\nBack-to-front��%d\nOrder��%d \n',averageWaitTime(1),averageWaitTime(2),averageWaitTime(3),averageWaitTime(4),averageWaitTime(5)); 

%����λʱ�������ӣ��۲���ʹ��ʱ��ı仯
% WaitdevtTime.TrunkWaiTime = 20;
% [q,b,c] = planesqueue(0,2,WaitdevtTime);
% q

%�����������ʱ�����λʱ�䷢���仯��ʱ�򣬵ǻ��ܵ�ʱ�䷢���ı仯ͼ
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
% xlabel('Abdicate Time/��t');
% ylabel('The boarding time/��t')

% 
% %������ʱ�ĵǻ�ʱ��͵ȴ�����
% WaitdevtTime.TrunkWaiTime = 1;
% for n = 1:5
%     for i = 1:30
%         [AllTime(n,i),ABDTimes(n,i),WaitTimes(n,i)] = planesqueue(0,n,WaitdevtTime);
%     end
% end
% 
% %��������  
% %�ܹ���ʱ
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
% title('�ܹ���ʱ2');
% %�ȴ�����
% figure(4);
% plot(i,WaitTimes(1,:),'b>-');
% hold on;
% plot(i,WaitTimes(2,:),'go-');
% plot(i,WaitTimes(3,:),'rx-');
% plot(i,WaitTimes(4,:),'cd-');
% plot(i,WaitTimes(5,:),'m+-');
% legend('Random','Outside-in','ReversePyramid','Back-to-front','Order');
% title('�ȴ�����2');
% 
% %��ƽ��ʱ��
% averageTime = zeros(1,5);
% for n = 1:5
%     for i = 1:30
%         averageTime(n) = AllTime(n,i) + averageTime(n);
%     end
%     averageTime(n) = int16(averageTime(n)/30);
% end
% fprintf('ƽ��ʱ��2:\nRandom��%3d \nOrder_Rand��%d\nRyramid��%d\nOrder2_Rand��%d\nOrder��%d \n',averageTime(1),averageTime(2),averageTime(3),averageTime(4),averageTime(5)); 
% 
% averageWaitTime = zeros(1,5);
% for n = 1:5
%     for i = 1:30
%         averageWaitTime(n) = WaitTimes(n,i) + averageWaitTime(n);
%     end
%     averageWaitTime(n) = int16(averageWaitTime(n)/30);
% end
% fprintf('\nƽ���ȴ�����2:\nRandom��%3d \nOrder_Rand��%d\nRyramid��%d\nOrder2_Rand��%d\nOrder��%d \n',averageWaitTime(1),averageWaitTime(2),averageWaitTime(3),averageWaitTime(4),averageWaitTime(5)); 


%�����Ѿ�ȷ����Outside-in�����ŵĵǽ������������ڶ����ڲ�ͬ��������ʱ�������£����л���ͼ��
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
% title('�ܹ���ʱ3');
% figure(6);
% plot(i,WaitTimes(1,:),'bo-');
% hold on;
% plot(i,WaitTimes(2,:),'go-');
% plot(i,WaitTimes(3,:),'ro-');
% plot(i,WaitTimes(4,:),'co-');
% plot(i,WaitTimes(5,:),'mo-');
% legend('Trunk2','Trunk4','Trunk6','Trunk8','Trunk10');
% title('�ȴ�����3');


%����ǻ�ģ�ͺ�outside-inģ����Ƚϣ�outside-in�����Ż�����\
%������λs
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


