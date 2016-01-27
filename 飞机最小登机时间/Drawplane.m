function Drawplane(R,RowNum,RowSeatNum)
%close all;
hold off;
plot(0,3.5,'ro');
axis([1 RowNum,1,RowSeatNum]);
grid on;
for i = 1:RowNum
    for n = 1:RowSeatNum
        if (R(i).SeatNum(n))
            plot(i,n,'o');
        end
        hold on;
        grid on;
    end
    if (R(i).CustomerNum ~= 0)
        plot(i,3.5,'ro');
        hold on;
        grid on;
    end
end
end