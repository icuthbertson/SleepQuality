figure('units','normalized','outerposition',[0 0 1 1],'PaperPositionMode','auto')

plot (starttime,move,'b','LineWidth',2);

set(gcf,'PaperOrientation','landscape')
set(gcf,'PaperUnits','normalized');
set(gcf,'PaperPosition', [0 0 1 1]);

axis([starttime(1),starttime(numel(starttime)),0,max(move)+1]);

NumTicks = 10;
L = get(gca,'XLim');
set(gca,'XTick',linspace(L(1),L(2),NumTicks))

datetick('x','HH:MMPM','keeplimits','keepticks');

set(gca,'XMinorTick','on','YMinorTick','on')

hold all;
%plot (starttime,move,'b','LineWidth',2);
plot (starttime,rem,'r','LineWidth',2);
plot (starttime,dist,'color',[0 0.5 0],'LineWidth',2);

h_legend = legend('Movement','REM Period','Disturbed Sleep Period','Location','northwest');
%h_legend = legend('Movement','Location','northwest');
%h_legend = legend('REM Period','Disturbed Sleep Period','Location','northwest');
%h_legend = legend('Disturbed Sleep Period','Location','northwest');

xlabel('Time of Night','FontSize',15);
ylabel('Classified Movement','FontSize',15);

title_string = strcat('Classified Movement, REM and Distributed Sleep',datestr(starttime(1),' mm-dd-yy'));
%title_string = strcat('Classified Movement',datestr(starttime(1),' mm-dd-yy'));
%title_string = strcat('REM Sleep',datestr(starttime(1),' mm-dd-yy'));
%title_string = strcat('Distributed Sleep',datestr(starttime(1),' mm-dd-yy'));

title(title_string,'FontSize',20);
set(h_legend,'FontSize',14);

print(gcf, '-dpdf', 'all.pdf','-r0');