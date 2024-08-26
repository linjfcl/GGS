
load("DEVIPS_test")
route = Detail.route;
IoTPosition = Data.IoTPosition;
f = figure;
hold on

iots = scatter(IoTPosition(:,1), IoTPosition(:,2), 150, 'filled', 's', 'MarkerFaceColor', '#7E2F8E');

Distance = pdist2(UAVPosition(:, 1:3), IoTPosition);
clear min;
[~,a]    = min(Distance,[],1);
for i = 1:size(UAVPosition,1)                   
    index = find(a == i);                      
    for ind = index
        ts = plot([UAVPosition(i, 1), IoTPosition(ind, 1)], ...
             [UAVPosition(i, 2), IoTPosition(ind, 2)], 'b--');
    end
end

sp = scatter(UAVPosition(:,1), UAVPosition(:,2), 100, 'filled', 'ko');

flyt = plot(UAVPosition(route, 1), UAVPosition(route, 2), 'Color', '#D95319', 'LineWidth', 2);

title("DEVIPS")

ax = f.Children(1);
ax.Box = 'on';              
ax.TickLength = [0, 0];    
ax.LineWidth=1.5;           

%%

load("GGS_test")
route = Detail.route;
IoTPosition = Data.IoTPosition;
f = figure;
hold on

iots = scatter(IoTPosition(:,1), IoTPosition(:,2), 150, 'filled', 's', 'MarkerFaceColor', '#7E2F8E');

Distance = pdist2(UAVPosition(:, 1:3), IoTPosition);
clear min;
[~,a]    = min(Distance,[],1);
for i = 1:size(UAVPosition,1)                 
    index = find(a == i);                      
    for ind = index
        ts = plot([UAVPosition(i, 1), IoTPosition(ind, 1)], ...
             [UAVPosition(i, 2), IoTPosition(ind, 2)], 'b--');
    end
end

sp = scatter(UAVPosition(:,1), UAVPosition(:,2), 100, 'filled', 'ko');

flyt = plot(UAVPosition(route, 1), UAVPosition(route, 2), 'Color', '#D95319', 'LineWidth', 2);

title("GGS")

ax = f.Children(1);
ax.Box = 'on';              
ax.TickLength = [0, 0];     
ax.LineWidth=1.5;           