clc;
clear;
close all

%% 绘制UAV飞行图像
load("GGS")
fprintf("最优值为%10.4f\n", fBest);
fprintf("无人机飞行长度为%10.1f米\n", Detail.tspLen)
fprintf("无人机运行时间为%10.1f秒\n", tBest)
fprintf("无人机飞行时间为%10.1f秒\n", Detail.tspLen / Para.speed)
fprintf("数据的传输时间为%10.1f秒\n", tBest - Detail.tspLen / Para.speed)
fprintf("        可以使用%10.1f天\n", 18000/(10+fBest));

figure
% 绘制背景
I = imread('map2.png');
image_dims = size(I);
imshow(I);
hold on

% 根据监测站类型绘制图标
IoTPoints1 = Data.IoTPosition0(Data.IoTPosition0(:, 3) == 1, :);
IoTPoints2 = Data.IoTPosition0(Data.IoTPosition0(:, 3) == 2, :);
IoTPoints3 = Data.IoTPosition0(Data.IoTPosition0(:, 3) == 3, :);
IoTPoints4 = Data.IoTPosition0(Data.IoTPosition0(:, 3) == 4, :);
wm = scatter(IoTPoints1(:,1), IoTPoints1(:,2), 100, 'filled', 'bv');
gm = scatter(IoTPoints2(:,1), IoTPoints2(:,2), 100, 'filled', 'rs');
mm = scatter(IoTPoints3(:,1), IoTPoints3(:,2), 100, 'filled', 'k^');
vm = scatter(IoTPoints4(:,1), IoTPoints4(:,2), 100, 'filled', 'gd');

% 绘制停止点
sp = scatter(UAVPosition(:,1)/Data.scale, UAVPosition(:,2)/Data.scale, 100, 'filled', 'ko');
% 绘制无人机轨迹
fy = plot(UAVPosition(Detail.route, 1)/Data.scale, UAVPosition(Detail.route, 2)/Data.scale,  'Color', '#D95319', 'LineWidth', 2);
% 绘制对应关系
for i = 1:size(Data.IoTPosition, 1)
    ts = plot([Data.IoTPosition(i, 1), UAVPosition(Detail.pair(i), 1)]/Data.scale, ...
         [Data.IoTPosition(i, 2), UAVPosition(Detail.pair(i), 2)]/Data.scale, 'b--');
end
% 绘制最关键的IoT节点（即消耗能量最高的节点）
me = plot([Data.IoTPosition(Detail.idx, 1), UAVPosition(Detail.pair(Detail.idx), 1)]/Data.scale, ...
     [Data.IoTPosition(Detail.idx, 2), UAVPosition(Detail.pair(Detail.idx), 2)]/Data.scale, 'k-', ...
     'LineWidth', 4);
% 选择一个点，作为机巢的位置
un = scatter(UAVPosition(2,1)/Data.scale, UAVPosition(2,2)/Data.scale, 700, 'filled', 'yp', 'MarkerEdgeColor', 'k');

% 图示
legend( [wm, gm, mm, vm, sp, fy, me, ts, un], ...
    {'Water quality monitoring', ...
    'Geological monitoring', ...
    'Meteorological monitoring',...
    'Video monitoring', ...
    "Hover point", ...
    "UAV trajectory", ...
    "Max energy consumption", ...
    "Transmission line", ...
    "UAV nest"}, ...
    'FontSize',12)

% 绘制坐标轴
ax = gca;
ax.XAxis.Visible = 'on';
ax.YAxis.Visible = 'on';
ax.YDir = 'normal';

ax.TickLength = [0, 0];     % 删除刻度线
ax.LineWidth=1;             % 框的粗细

ax.XTick = linspace(0, image_dims(1), 11);
ax.YTick = linspace(0, image_dims(2), 11);

ax.XTickLabel = 0:500:5000;
ax.YTickLabel = 0:500:5000;

ax.LineWidth=1.5;

xlabel("$x$ [m]", "Interpreter","latex")
ylabel("$y$ [m]", "Interpreter","latex")

exportgraphics(gcf, 'result.pdf')