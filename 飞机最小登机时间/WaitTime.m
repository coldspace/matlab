function [time,T] = WaitTime(Seat,Trunk,R,T,WaitdevtTime)
%�趨����������ֵ�ʱ�� ���µ�λΪ��
%����ÿ�����ƶ����ٶ�Ϊһ����һ��
 TrunkWaiTime = WaitdevtTime.TrunkWaiTime ; %����7�� ���������ʱ��
 FirstAbdTime = WaitdevtTime.FirstAbdTime; %��һ������λ��Ҫ��ʱ��
SecondAbdTime = WaitdevtTime.SecondAbdTime;%�ڶ�������λ��Ҫ��ʱ��

if (Trunk)
    time = TrunkWaiTime ;
else
    time = 0;
end

switch Seat
    case 1
        if (R.SeatNum(3))
           time = time + FirstAbdTime;
           T.FirstPeople = T.FirstPeople + 1;
        end
        if (R.SeatNum(2))
           time = time + SecondAbdTime;
           T.SecondPeople = T.SecondPeople + 1;
        end
        
        if ( (R.SeatNum(2)) && (R.SeatNum(3)))
            T.FSPeople = T.FSPeople + 1;
        end
    case 2
        if (R.SeatNum(3))
           time = time + FirstAbdTime;
           T.FirstPeople = T.FirstPeople + 1;
        end
    case 5
        if (R.SeatNum(4))
            time = time + FirstAbdTime;
            T.FirstPeople = T.FirstPeople + 1;
        end
    case 6
        if (R.SeatNum(4))
            time = time + FirstAbdTime;
            T.FirstPeople = T.FirstPeople + 1;
        end
        if (R.SeatNum(5))
            time = time + SecondAbdTime;
            T.SecondPeople = T.SecondPeople + 1;
        end
        if ( (R.SeatNum(4)) && (R.SeatNum(5)))
            T.FSPeople = T.FSPeople + 1;
        end
end
