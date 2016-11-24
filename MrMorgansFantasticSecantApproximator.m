function SecantApproximator
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
    'Callback',@popup_menu_Callback);
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
haxes = axes('Units','pixels','Position',[50,60,500,600]);

% Initialize the UI.
% Change units to normalized so components resize automatically
% Assign the a name to appear in the window title.
hfig.Name = 'Mr Morgans Fantastic Secant Approximator';
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
                x = [0:15];
                f1 = (x-2).^2+8;
                plot(x,f1);
                axis([0 15 0 180])
                hold on
                
                prompt = {'Please enter the number of secant lines you would like'};
                title_text = '# of Secant Lines';
                num_lines = 1;
                numsec = inputdlg(prompt,title_text,[1 50]);
                numsec = numsec{:};
                numsec = str2num(numsec);
                secxs = [min(x):(max(x)-min(x))/numsec:max(x)];
                f2 = (secxs-2).^2+8;
                plot(secxs,f2,'k-d','MarkerSize',10,'MarkerFaceColor','k');
                hold off
                legend('(x-2)^2+8','secant approx')
                
            case 'graph2'
                cla
                x = linspace(-5,5);
                f1 = x.^3;
                plot(x,f1);
                axis([-5 5 -150 150])
                hold on
                
                prompt = {'Please enter the number of secant lines you would like'};
                title_text = '# of Secant Lines';
                num_lines = 1;
                numsec = inputdlg(prompt,title_text,[1 50]);
                numsec = numsec{:};
                numsec = str2num(numsec);
                secxs = [min(x):(max(x)-min(x))/numsec:max(x)];
                f2 = secxs.^3;
                plot(secxs,f2,'k-d','MarkerSize',10,'MarkerFaceColor','k');
                hold off
                legend('x^3','secant approx')
            case 'graph3'
                cla
                x = linspace(0,7);
                f1 = sin(x);
                plot(x,f1);
                axis([0 7 -1.2 1.2])
                hold on
                
                prompt = {'Please enter the number of secant lines you would like'};
                title_text = '# of Secant Lines';
                num_lines = 1;
                numsec = inputdlg(prompt,title_text,[1 50]);
                numsec = numsec{:};
                numsec = str2num(numsec);
                secxs = [min(x):(max(x)-min(x))/numsec:max(x)];
                f2 = sin(secxs);
                plot(secxs,f2,'k-d','MarkerSize',10,'MarkerFaceColor','k');
                hold off
                legend('sin(x)','secant approx')
        end
    end
end