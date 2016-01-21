function [r_path , r_cost] =dijkstra(pathS,pathE,transmat)
%pathS：所求最短路径的起点
%pathE：所求最短路径的终点
%transmat：图的转移矩阵或邻接矩阵，应为方阵
if (size(transmat,1) ~= size(transmat,2) )
 error('detect_cycles:Dijkstra_SC');
    end 
 noOfNode=size(transmat , 1);
 for i = 1:noOfNode
     parent(i) = 0;
     distance(i)=Inf;
 end
 queue=[];
 
 for  i=1:noOfNode
     if  transmat(pathS,i)~=Inf
         distance(i)=transmat(pathS ,i);
         parent(i)=pathS;
         queue  =[queue i];
     end 
 end
 
 
 while length(queue)~= 0
     hopS = queue(1);
     queue = queue(2:end);
     
     for hopE = 1:noOfNode
         if distance(hopE)>distance(hopS) + transmat(hopS,hopE)
             distance(hopE) = distance(hopS)+ transmat(hopS,hopE);  %更新
             parent(hopE)=hopS;
             queue = [queue hopE];
         end 
     end
 end 
 
     r_path = [pathE];
     i = parent(pathE);
     
     while i ~=pathS && i~=0
         r_path = [i r_path];
         i  = parent(i);
     end 
     if i==pathS
         r_path=[i r_path];
     else
         r_path =[]
     end
     r_cost = distance(pathE);
