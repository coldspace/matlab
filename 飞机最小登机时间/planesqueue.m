function [Ti,ABDTimes,WaitTimes]=planesqueue(DR2,Randmode,WaitdevtTime)
    %DR2表示是否需要动态图，1表示有图，0则没有动态图
    %设定各种情况出现的时间
    % TrunkWaiTime = 7; %假设7秒
    % FirstAbdTime = 2; %第一个人让位需要的时间
    % SecondAbdTime = 2;%第二个人让位需要的时间
    global RowNum;
    global RowSeatNum;
    
    RowNum = 63; %排数
    RowSeatNum = 6;%列数
    WaitTimes = 0;  %等待时间，初始化为0
    
    ABDTimes.FirstPeople = 0;
    ABDTimes.SecondPeople = 0;
    ABDTimes.FSPeople = 0;

    %过道每一排的属性
    %重新将每个位置的值清空，表示乘客没有坐上去
    %Row结构体中
    %Customer表示乘客号码         0表示没有被占用
    %WaitTime表示该过道被占用的时间
    %SeatNum(n)表示在座位号为n的位置上面，是否有人；
    for i = 1:RowNum
        Row(i).CustomerNum = 0;   %乘客数
        Row(i).WaitTime = 0;
        for n = 1:RowSeatNum
            Row(i).SeatNum(n) = 0;
        end
    end

    %乘客初始化
    for i = 1:(RowNum*RowSeatNum)
     %   Customer(i).MoveSpeed = 1;      %表示正常情况下，每秒移动一个位置
        Customer(i).Trunk = 1;
        Customer(i).GoalRow = 0;    %目标排数1~30  初始化为1
        Customer(i).GoalSeat = 0;   %在某排的座位序号1~6    初始化为1
    end
    %采用蒙特卡洛发 生成每一个乘客的座位号 进而计算模型的正确性
    %Monte(); 完全随机座位
    %Order_Rand(); %顺序型，根据从靠窗到走廊的顺序进行登记顺序安排
    %Ryramid();%根据倒金字塔的方法，越在靠近飞机里面的乘客越优先登录
    %Order2_Rand();%根据座位顺序，从飞机里面到外面
    %Order();% 顺序型从到外，从靠窗到走廊 ，最优方法，但是不可能在实际过程中实现 
    switch Randmode
        case 1
            Monte();
        case 2
            Order_Rand();
        case 3
            Ryramid();
        case 4
            Order2_Rand();
        case 5
            Order();
    end
    
    %
    for i = 1:RowNum
        Row(i).CustomerNum = 0;   %乘客数
        Row(i).WaitTime = 0;
        for n = 1:RowSeatNum
            Row(i).SeatNum(n) = 0;
        end
    end
    Ti = 0; %整个登机时间记录
    StepTime = 1; %单位是秒

    flog = 1;
    CNM = 1;
    %数据处理，动态图输出
    while(flog)
        Ti = Ti + StepTime;
        if (Row(RowNum).CustomerNum == 0)
            Row(RowNum).CustomerNum = CNM;
            if ((CNM == 0) || (CNM == RowNum * RowSeatNum))
                CNM = 0;
            else
                CNM = CNM+1;
            end
        end

        for i = 1:RowNum
            if (Row(i).CustomerNum ~= 0)
                if(Row(i).WaitTime > 0)
                    Row(i).WaitTime = Row(i).WaitTime - 1;
                    if(Row(i).WaitTime == 0)
                        Row(i).SeatNum(Customer(Row(i).CustomerNum).GoalSeat) = 1;
                        Row(i).CustomerNum = 0;
                    end
                elseif( Customer(Row(i).CustomerNum). GoalRow == i)
                    [Row(i).WaitTime,ABDTimes] = WaitTime(Customer(Row(i).CustomerNum).GoalSeat,Customer(Row(i).CustomerNum).Trunk,Row(i),ABDTimes,WaitdevtTime);
   %                 fprintf ('Customer:"%3d" Row("%2d").WaitTime = "%2d"\n',Row(i).CustomerNum,i,Row(i).WaitTime);
                elseif ( (i -1) > 0 )
              %      fprintf('%d\n',i)
                    if (Row(i - 1).CustomerNum == 0)
                        Row(i - 1).CustomerNum = Row(i).CustomerNum;
                        Row(i).CustomerNum = 0;
                    else
                        WaitTimes  = WaitTimes + 1;
                    end
                end
            end
        end
         %  fprintf('Customer1：%3d   Row: %2d  Seat: %2d  \n', CNM - 1,Customer(CNM - 1).GoalRow,Customer(CNM - 1).GoalSeat);   
        if (CNM == 0)   
            flog = 0;
            for i = 1:RowNum            %判断是否全部坐上座位
                if (Row(i).CustomerNum > 0)
                    flog = 1;
                end
            end
        end
        if DR2
            Drawplane(Row,RowNum,RowSeatNum);%绘制图形
            pause(0.1);%程序暂停0.1秒
        end

    end

%     Ti              %输出数据，程序截止
%     ABDTimes

    %函数定义区域蒙特卡洛方法
    %完全随机模型
    function Monte()
    %采用蒙特卡洛发 生成每一个乘客的座位号 进而计算模型的正确性
        for i = 1:(RowNum*RowSeatNum)
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,RowNum) + 1;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,RowSeatNum) + 1;
            flog = 1;
            while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %目标排数1~30  初始化为1
                    Customer(i).GoalSeat = CosProSeat;   %在某排的座位序号1~6    初始化为1
%                     fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
                 test = round(rand(1,1) * 10000);
                 CosProRow = mod(test,RowNum) + 1;
                 test = round(rand(1,1) * 10000);
                 CosProSeat = mod(test,RowSeatNum) + 1;
            end
        end
    end

    %顺序型，根据从靠窗到走廊的顺序进行登记顺序安排
    function Order_Rand()
       for i = 1:(RowNum*RowSeatNum)
           if i <= (2*RowNum)
               CosProSeat = random2num(1,6);              
           elseif i<=(4*RowNum)
               CosProSeat = random2num(2,5);   
           elseif i<= (6*RowNum)
               CosProSeat = random2num(3,4);   
           end
           test = round(rand(1,1) * 10000);
           CosProRow = mod(test,RowNum) + 1;
           
           flog = 1;
            while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %目标排数1~30  初始化为1
                    Customer(i).GoalSeat = CosProSeat;   %在某排的座位序号1~6    初始化为1
%                     fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
               if i <= (2*RowNum)
                   CosProSeat = random2num(1,6);              
               elseif i<=(4*RowNum)
                   CosProSeat = random2num(2,5);   
               elseif i<= (6*RowNum)
                   CosProSeat = random2num(3,4);   
               end
               test = round(rand(1,1) * 10000);
               CosProRow = mod(test,RowNum) + 1;
            end
       end
    end

    %根据倒金字塔的方法，越在靠近飞机里面的乘客越优先登录
     function Ryramid()
         for i = 1:(RowNum*RowSeatNum)
             [CosProSeat,CosProRow] = RyramidGetSeatNum(i);
             flog = 1;
             while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %目标排数1~30  初始化为1
                    Customer(i).GoalSeat = CosProSeat;   %在某排的座位序号1~6    初始化为1
%                     fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
                [CosProSeat,CosProRow] = RyramidGetSeatNum(i);
            end
         end
     end
 
    %根据座位顺序，从飞机里面到外面。
    function Order2_Rand()
        for i = 1:(RowNum*RowSeatNum)
             [CosProSeat,CosProRow] = Order2_RandGetNum(i);
             flog = 1;
             while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %目标排数1~30  初始化为1
                    Customer(i).GoalSeat = CosProSeat;   %在某排的座位序号1~6    初始化为1
%                     fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
                [CosProSeat,CosProRow] = Order2_RandGetNum(i);
            end
         end
    end
 
    % 顺序型从到外，从靠窗到走廊 ，最优方法，但是不可能在实际过程中实现 
    function Order()
         for n = 1:(RowSeatNum/2)
             for i = 1:(RowNum)
                 Customer(i + (n-1) * 2*RowNum).GoalRow = i;    
                 Customer(i + (n-1) * 2*RowNum).GoalSeat = n;
%                  fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n',i + (n-1) * 2*RowNum,i,n);
             end
             for i = 1:(RowNum)
                 Customer(i + (n-1) * 2*RowNum + RowNum).GoalRow = i;    
                 Customer(i + (n-1) * 2*RowNum + RowNum).GoalSeat = RowSeatNum + 1 - n;   
%                  fprintf('Customer：%3d   Row: %2d  Seat: %2d  \n',i + (n-1) * 2*RowNum + RowNum,i,RowSeatNum + 1 - n);
             end
         end
    end
    
    %辅助函数1——金字塔模型中，选择出座位号
    function [CosProSeat,CosProRow]=RyramidGetSeatNum(i)
        if i<=30
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,10) + 1;
            if CosProRow <= 5
                CosProSeat = random4num(1,2,5,6);
            elseif CosProRow <= 10
                CosProSeat = random2num(1,6);
            end
        elseif i<=60
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,15) + 1;
            if CosProRow <= 5
                CosProSeat = random2num(3,4);
            elseif CosProRow <= 10
                CosProSeat = random2num(2,5);
            elseif CosProRow <= 15
                CosProSeat = random2num(1,6);
            end
        elseif i<=90
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,15) + 1 + 5;
            if CosProRow<=10
                CosProSeat = random2num(3,4);
            elseif CosProRow<=15
                CosProSeat = random2num(2,5);
            elseif CosProRow<=20
                CosProSeat = random2num(1,6);
            end
        elseif i<=120
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,10) + 1 + 10;
            if CosProRow <= 15
                CosProSeat = random2num(3,4);
            elseif CosProRow <= 20
                CosProSeat = random4num(2,3,4,5);
            end
        end
    end   
    %辅助函数1-1——在4个数值中，随机选择一个
    function num = random4num(a,b,c,d)
        test = round(rand(1,1) * 10000);
        test = mod(test,4) + 1;
        switch test
            case 1
                num = a;
            case 2
                num = b;
            case 3
                num = c;
            case 4
                num = d;
        end
    end
    %辅助函数2——在从飞机里面到外面排序的这个模型中，选择出座位号
    function [CosProSeat,CosProRow] = Order2_RandGetNum(i)
        if i<=30
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,5) + 1;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,6) + 1;
        elseif i<=60
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,5) + 1 + 5;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,6) + 1;
        elseif i<=90
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,5) + 1 + 10;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,6) + 1;
        elseif i<=120
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,5) + 1 + 15;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,6) + 1;
        end
    end 
end




    
    
