function [Ti,ABDTimes,WaitTimes]=planesqueue(DR2,Randmode,WaitdevtTime)
    %DR2��ʾ�Ƿ���Ҫ��̬ͼ��1��ʾ��ͼ��0��û�ж�̬ͼ
    %�趨����������ֵ�ʱ��
    % TrunkWaiTime = 7; %����7��
    % FirstAbdTime = 2; %��һ������λ��Ҫ��ʱ��
    % SecondAbdTime = 2;%�ڶ�������λ��Ҫ��ʱ��
    global RowNum;
    global RowSeatNum;
    
    RowNum = 63; %����
    RowSeatNum = 6;%����
    WaitTimes = 0;  %�ȴ�ʱ�䣬��ʼ��Ϊ0
    
    ABDTimes.FirstPeople = 0;
    ABDTimes.SecondPeople = 0;
    ABDTimes.FSPeople = 0;

    %����ÿһ�ŵ�����
    %���½�ÿ��λ�õ�ֵ��գ���ʾ�˿�û������ȥ
    %Row�ṹ����
    %Customer��ʾ�˿ͺ���         0��ʾû�б�ռ��
    %WaitTime��ʾ�ù�����ռ�õ�ʱ��
    %SeatNum(n)��ʾ����λ��Ϊn��λ�����棬�Ƿ����ˣ�
    for i = 1:RowNum
        Row(i).CustomerNum = 0;   %�˿���
        Row(i).WaitTime = 0;
        for n = 1:RowSeatNum
            Row(i).SeatNum(n) = 0;
        end
    end

    %�˿ͳ�ʼ��
    for i = 1:(RowNum*RowSeatNum)
     %   Customer(i).MoveSpeed = 1;      %��ʾ��������£�ÿ���ƶ�һ��λ��
        Customer(i).Trunk = 1;
        Customer(i).GoalRow = 0;    %Ŀ������1~30  ��ʼ��Ϊ1
        Customer(i).GoalSeat = 0;   %��ĳ�ŵ���λ���1~6    ��ʼ��Ϊ1
    end
    %�������ؿ��巢 ����ÿһ���˿͵���λ�� ��������ģ�͵���ȷ��
    %Monte(); ��ȫ�����λ
    %Order_Rand(); %˳���ͣ����ݴӿ��������ȵ�˳����еǼ�˳����
    %Ryramid();%���ݵ��������ķ�����Խ�ڿ����ɻ�����ĳ˿�Խ���ȵ�¼
    %Order2_Rand();%������λ˳�򣬴ӷɻ����浽����
    %Order();% ˳���ʹӵ��⣬�ӿ��������� �����ŷ��������ǲ�������ʵ�ʹ�����ʵ�� 
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
        Row(i).CustomerNum = 0;   %�˿���
        Row(i).WaitTime = 0;
        for n = 1:RowSeatNum
            Row(i).SeatNum(n) = 0;
        end
    end
    Ti = 0; %�����ǻ�ʱ���¼
    StepTime = 1; %��λ����

    flog = 1;
    CNM = 1;
    %���ݴ�����̬ͼ���
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
         %  fprintf('Customer1��%3d   Row: %2d  Seat: %2d  \n', CNM - 1,Customer(CNM - 1).GoalRow,Customer(CNM - 1).GoalSeat);   
        if (CNM == 0)   
            flog = 0;
            for i = 1:RowNum            %�ж��Ƿ�ȫ��������λ
                if (Row(i).CustomerNum > 0)
                    flog = 1;
                end
            end
        end
        if DR2
            Drawplane(Row,RowNum,RowSeatNum);%����ͼ��
            pause(0.1);%������ͣ0.1��
        end

    end

%     Ti              %������ݣ������ֹ
%     ABDTimes

    %���������������ؿ��巽��
    %��ȫ���ģ��
    function Monte()
    %�������ؿ��巢 ����ÿһ���˿͵���λ�� ��������ģ�͵���ȷ��
        for i = 1:(RowNum*RowSeatNum)
            test = round(rand(1,1) * 10000);
            CosProRow = mod(test,RowNum) + 1;
            test = round(rand(1,1) * 10000);
            CosProSeat = mod(test,RowSeatNum) + 1;
            flog = 1;
            while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %Ŀ������1~30  ��ʼ��Ϊ1
                    Customer(i).GoalSeat = CosProSeat;   %��ĳ�ŵ���λ���1~6    ��ʼ��Ϊ1
%                     fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
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

    %˳���ͣ����ݴӿ��������ȵ�˳����еǼ�˳����
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
                    Customer(i).GoalRow = CosProRow;    %Ŀ������1~30  ��ʼ��Ϊ1
                    Customer(i).GoalSeat = CosProSeat;   %��ĳ�ŵ���λ���1~6    ��ʼ��Ϊ1
%                     fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
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

    %���ݵ��������ķ�����Խ�ڿ����ɻ�����ĳ˿�Խ���ȵ�¼
     function Ryramid()
         for i = 1:(RowNum*RowSeatNum)
             [CosProSeat,CosProRow] = RyramidGetSeatNum(i);
             flog = 1;
             while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %Ŀ������1~30  ��ʼ��Ϊ1
                    Customer(i).GoalSeat = CosProSeat;   %��ĳ�ŵ���λ���1~6    ��ʼ��Ϊ1
%                     fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
                [CosProSeat,CosProRow] = RyramidGetSeatNum(i);
            end
         end
     end
 
    %������λ˳�򣬴ӷɻ����浽���档
    function Order2_Rand()
        for i = 1:(RowNum*RowSeatNum)
             [CosProSeat,CosProRow] = Order2_RandGetNum(i);
             flog = 1;
             while (flog)
                if (Row(CosProRow).SeatNum(CosProSeat) ~= 1)
                    Row(CosProRow).SeatNum(CosProSeat) = 1;
                    Customer(i).GoalRow = CosProRow;    %Ŀ������1~30  ��ʼ��Ϊ1
                    Customer(i).GoalSeat = CosProSeat;   %��ĳ�ŵ���λ���1~6    ��ʼ��Ϊ1
%                     fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n', i,CosProRow,CosProSeat);
%                     fprintf('\n');
                    flog = 0;
                end
                [CosProSeat,CosProRow] = Order2_RandGetNum(i);
            end
         end
    end
 
    % ˳���ʹӵ��⣬�ӿ��������� �����ŷ��������ǲ�������ʵ�ʹ�����ʵ�� 
    function Order()
         for n = 1:(RowSeatNum/2)
             for i = 1:(RowNum)
                 Customer(i + (n-1) * 2*RowNum).GoalRow = i;    
                 Customer(i + (n-1) * 2*RowNum).GoalSeat = n;
%                  fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n',i + (n-1) * 2*RowNum,i,n);
             end
             for i = 1:(RowNum)
                 Customer(i + (n-1) * 2*RowNum + RowNum).GoalRow = i;    
                 Customer(i + (n-1) * 2*RowNum + RowNum).GoalSeat = RowSeatNum + 1 - n;   
%                  fprintf('Customer��%3d   Row: %2d  Seat: %2d  \n',i + (n-1) * 2*RowNum + RowNum,i,RowSeatNum + 1 - n);
             end
         end
    end
    
    %��������1����������ģ���У�ѡ�����λ��
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
    %��������1-1������4����ֵ�У����ѡ��һ��
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
    %��������2�����ڴӷɻ����浽������������ģ���У�ѡ�����λ��
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




    
    
