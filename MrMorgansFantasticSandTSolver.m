function MrMorgansFantasticSandTSolver
%a simple app for calculating tangent and secant lines on curves,
%displaying them, and calculating the percent difference
%design by Robert Morgan
%last update Nov 21, 2016
%for EDU 210

type = 'graph1';
x = linspace(0,15);
f1 = (x-2).^2+8;
%Create and then hide the UI as it is being constructed.
hfig = figure('Visible','off','Position',[360,500,850,700],...
    'Color',[0.7 0.7 0.7],'MenuBar','none');
%% CONSTRUCTION OF THE FIGURE ELEMENTS
% Construct the computing the lines
hcompute = uicontrol('Style','pushbutton',...
    'Position',[618,40,175,175],...
    'Callback',@compute_Callback,...
    'BackgroundColor',[0.145 0.694 0.301],...
    'Units','normalized',...
    'String','COMPUTE','FontSize',20);
% Construct the component for the graph selection
hpopup = uicontrol('Style','popupmenu',...
    'String',{'(x-2)^2+8','x^3','sin(x)'},...
    'Position',[618,515,175,65],...
    'Callback',@popup_menu_Callback,...
    'Units','normalized');
hpopuptext = uicontrol('Style','text',...
    'Position',[618,595,175,35],'String','Graph',...
    'FontSize',20,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
% Construct the components for the answers
hsecanttext = uicontrol('Style','text',...
    'Position',[618,485,175,35],'String','Secant slope:',...
    'FontSize',20,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
hsecantvalue = uicontrol('Style','text',...
    'Position',[618,450,175,35],'String','0',...
    'FontSize',15,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
htangenttext = uicontrol('Style','text',...
    'Position',[618,415,175,35],'String','Tangent slope:',...
    'FontSize',20,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
htangentvalue = uicontrol('Style','text',...
    'Position',[618,380,175,35],'String','0',...
    'FontSize',15,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
hxpoint = uicontrol('Style','text',...
    'Position',[618,345,175,35],'String','x = 0',...
    'FontSize',15,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
hypoint = uicontrol('Style','text',...
    'Position',[618,315,175,35],'String','y = 0',...
    'FontSize',15,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
hpdifftext = uicontrol('Style','text',...
    'Position',[618,280,175,35],'String','% Difference:',...
    'FontSize',20,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
hpdiffvalue = uicontrol('Style','text',...
    'Position',[618,245,175,35],'String','0',...
    'FontSize',15,'BackgroundColor',[0.7 0.7 0.7],'Units','normalized');
%Construct the axes of the graph
haxes = axes('Units','pixels','Position',[50,60,500,600],...
    'Units','normalized');

% Initialize the UI.
% Change units to normalized so components resize automatically
% Assign the a name to appear in the window title.
hfig.Name = 'Mr Morgans Fantastic Secant and Tangent Line Solver';
% Move the window to the center of the screen.
movegui(hfig,'center')
% Make the window visible.
plot(x,f1);
hfig.Visible = 'on';

    function popup_menu_Callback(source,eventdata) %get the graph type
        str = get(source, 'String');
        val = get(source,'Value');
        % Set current data to the selected data set.
        switch str{val};
            case '(x-2)^2+8' % User selects (x-2)^2+8
                type = 'graph1';
            case 'x^3' % User selects x^3
                type = 'graph2';
            case 'sin(x)' % User selects sinx+cosx
                type = 'graph3';
        end
    end

    function compute_Callback(source,eventdata) %draw the graphs and get info
        switch type
            case 'graph1'
                cla
                x = linspace(0,15);
                f1 = (x-2).^2+8;
                plot(x,f1);
                axis([0 15 0 180])
                hold on
                
                prompt = {'Please enter an x value for the left bound'};
                title_text = 'Left Bound';
                num_lines = 1;
                x1 = inputdlg(prompt,title_text,[1 50]);
                x1 = x1{:};
                x1 = str2num(x1);
                y1 = (x1-2)^2+8;
                
                prompt = {'Please enter an x value for the right bound'};
                title_text = 'Right Bound';
                num_lines = 1;
                x2 = inputdlg(prompt,title_text,[1 50]);
                x2 = x2{:};
                x2 = str2num(x2);
                y2 = (x2-2)^2+8;
                
                secslope = (y2-y1)/(x2-x1);
                plot([x1 x2],[y1 y2],'k-d','MarkerSize',10,'MarkerFaceColor','k')
                hsecantvalue.String = num2str(round(secslope,2));
                
                prompt = {'Please enter an x value between the bounds for the tangent line'};
                title_text = 'Tangent line';
                num_lines = 1;
                xtan = inputdlg(prompt,title_text,[1 50]);
                xtan = xtan{:};
                xtan = str2num(xtan);
                ytan = (xtan-2)^2+8;
                tanslope = 2*(xtan-2);
                x = linspace(xtan-1,xtan+1);
                f3 = tanslope*(x-xtan)+ytan;
                plot(x,f3,'r')
                plot(xtan,ytan,'ro','MarkerSize',10,'MarkerFaceColor','r')
                htangentvalue.String = strcat(num2str(round(tanslope,2)),' @');
                hxpoint.String = strcat('x = ',num2str(round(xtan,2)));
                hypoint.String = strcat('y = ',num2str(round(ytan,2)));
                hold off
                legend('(x-2)^2+8','secant','tangent')
                
                pdiff = abs((round(tanslope,2)-round(secslope,2))/round(tanslope,2))*100;
                hpdiffvalue.String = strcat(num2str(round(pdiff,2)),'%');
            case 'graph2'
                cla
                x = linspace(-5,5);
                f1 = x.^3
                plot(x,f1);
                axis([-5 5 -150 150])
                hold on
                
                prompt = {'Please enter an x value for the left bound'};
                title_text = 'Left Bound';
                num_lines = 1;
                x1 = inputdlg(prompt,title_text,[1 50]);
                x1 = x1{:};
                x1 = str2num(x1);
                y1 = x1^3;
                
                prompt = {'Please enter an x value for the right bound'};
                title_text = 'Right Bound';
                num_lines = 1;
                x2 = inputdlg(prompt,title_text,[1 50]);
                x2 = x2{:};
                x2 = str2num(x2);
                y2 = x2^3;
                
                secslope = (y2-y1)/(x2-x1);
                plot([x1 x2],[y1 y2],'k-d','MarkerSize',10,'MarkerFaceColor','k')
                hsecantvalue.String = num2str(round(secslope,2));
                
                prompt = {'Please enter an x value between the bounds for the tangent line'};
                title_text = 'Tangent line';
                num_lines = 1;
                xtan = inputdlg(prompt,title_text,[1 50]);
                xtan = xtan{:};
                xtan = str2num(xtan);
                ytan = xtan^3;
                tanslope = 3*xtan^2;
                x = linspace(xtan-1,xtan+1);
                f3 = tanslope*(x-xtan)+ytan;
                plot(x,f3,'r')
                plot(xtan,ytan,'ro','MarkerSize',10,'MarkerFaceColor','r')
                htangentvalue.String = strcat(num2str(round(tanslope,2)),' @');
                hxpoint.String = strcat('x = ',num2str(round(xtan,2)));
                hypoint.String = strcat('y = ',num2str(round(ytan,2)));
                hold off
                legend('x^3','secant','tangent')
                
                pdiff = abs((round(tanslope,2)-round(secslope,2))/round(tanslope,2))*100;
                hpdiffvalue.String = strcat(num2str(round(pdiff,2)),'%');
            case 'graph3'
                cla
                x = linspace(0,7);
                f1 = sin(x);
                plot(x,f1);
                axis([0 7 -1.2 1.2])
                hold on
                
                prompt = {'Please enter an x value for the left bound'};
                title_text = 'Left Bound';
                num_lines = 1;
                x1 = inputdlg(prompt,title_text,[1 50]);
                x1 = x1{:};
                x1 = str2num(x1);
                y1 = sin(x1);
                
                prompt = {'Please enter an x value for the right bound'};
                title_text = 'Right Bound';
                num_lines = 1;
                x2 = inputdlg(prompt,title_text,[1 50]);
                x2 = x2{:};
                x2 = str2num(x2);
                y2 = sin(x2);
                
                secslope = (y2-y1)/(x2-x1);
                plot([x1 x2],[y1 y2],'k-d','MarkerSize',10,'MarkerFaceColor','k')
                hsecantvalue.String = num2str(round(secslope,2));
                
                prompt = {'Please enter an x value between the bounds for the tangent line'};
                title_text = 'Tangent line';
                num_lines = 1;
                xtan = inputdlg(prompt,title_text,[1 50]);
                xtan = xtan{:};
                xtan = str2num(xtan);
                ytan = sin(xtan);
                tanslope = cos(xtan);
                x = linspace(xtan-1,xtan+1);
                f3 = tanslope*(x-xtan)+ytan;
                plot(x,f3,'r')
                plot(xtan,ytan,'ro','MarkerSize',10,'MarkerFaceColor','r')
                htangentvalue.String = strcat(num2str(round(tanslope,2)),' @');
                hxpoint.String = strcat('x = ',num2str(round(xtan,2)));
                hypoint.String = strcat('y = ',num2str(round(ytan,2)));
                hold off
                legend('sin(x)','secant','tangent')
                
                pdiff = abs((round(tanslope,2)-round(secslope,2))/round(tanslope,2))*100;
                hpdiffvalue.String = strcat(num2str(round(pdiff,2)),'%');
        end
    end
end
