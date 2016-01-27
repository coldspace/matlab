function [time,T] = WaitTime(Seat,Trunk,R,T,WaitdevtTime)
%设定各种情况出现的时间 以下单位为秒
%假设每个人移动的速度为一秒钟一格
 TrunkWaiTime = WaitdevtTime.TrunkWaiTime ; %假设7秒 放置行李的时间
 FirstAbdTime = WaitdevtTime.FirstAbdTime; %第一个人让位需要的时间
SecondAbdTime = WaitdevtTime.SecondAbdTime;%第二个人让位需要的时间

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
