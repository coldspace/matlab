clc
clear all;
close all;
clc,clear,close all
W=[0 1 2 Inf 7 4 8 Inf;
    1 0 2 5 Inf Inf 7 Inf;
    2 2 0 1 5 Inf Inf Inf;
    Inf 5 1 0 3 Inf Inf 6;
    7 Inf 5 3 0 3 Inf 4;
    4 Inf Inf Inf 3 0 2 6;
    8 7 Inf Inf Inf 2 0 4;
    Inf Inf Inf 6 4 6 4 0
    ];
[r_path,r_cost] = dijkstra(1,6,W)