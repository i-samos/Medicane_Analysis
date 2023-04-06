function varargout = medicanes(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @medicanes_OpeningFcn, ...
    'gui_OutputFcn',  @medicanes_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function medicanes_OpeningFcn(hObject, eventdata, handles, varargin)
jarDir=pwd;
javaaddpath(jarDir);

d = dir(jarDir);
for i = 1:length(d)
    name = java.lang.String(d(i).name);
    if name.endsWith('.jar') & ~name.startsWith('.')
        javaaddpath(fullfile(jarDir, d(i).name));
    end
end
INITIAL = pwd;
INITIAL=strcat(INITIAL,'\INPUT_GRIB\');
assignin('base','INITIAL',INITIAL);
initial_function(@initial_function, eventdata, handles)
handles.output = hObject;
guidata(hObject, handles);
CC3=evalin('base','CC3');
ll_str=unique(CC3(:,18));
set(handles.listbox1,'String',ll_str);
A=get(handles.listbox1, 'Value');
B=get(handles.listbox1, 'String');
CC3=evalin('base','CC3');
stringToCheck = B(A);
member=find(strcmp(stringToCheck,CC3(:,19)));
CC5=CC3(member,:);
CC5=sortrows(CC5,[17,18]);
Q1=strcmp(CC5(:,4),'GeoDynamic Height');
Q2=strcmp(CC5(:,4),'MSL Pressure');
QQ=logical(Q1+Q2);
CC5=CC5(QQ,:);
assignin('base','CC5',CC5); %this has all the pressure levels
temp=cell2mat(CC5(:,7));
qwe3=str2double(get(handles.edit1, 'String'));
qwe2=str2double(get(handles.edit2, 'String'));
qwe1=str2double(get(handles.edit3, 'String'));
Q=temp==0|temp==qwe1 | temp==qwe2 |temp==qwe3;
CC55=CC5(Q,:);
assignin('base','CC55',CC55); %this has the info for B and Vt calculations based on edit boxes
% timestamp=CC55{1,18};
axes(handles.axes1);
title('Mean Sea Level Pressure')
Q2=strcmp(CC55(:,4),'MSL Pressure');
CC56=CC55(Q2,:);
IDX=str2double(char(CC56(1,1)));
IDX2=char(CC56(1,16));
assignin('base','IDX2',IDX2);
assignin('base','IDX',IDX);
[lat,lon,data]=read_grib1_time(IDX, IDX2);
S=evalin('base','S');
data=data/100;
hold on
PCOLOR_FIGURE_HANDLE1=pcolor(lat,lon,data);shading interp
PCOLOR_FIGURE_HANDLE2=plot([S.X], [S.Y],'Color','black','LineWidth',0.5);
hold off
axis([min(min(lat)) max(max(lat)) min(min(lon)) max(max(lon))]);
colorbar;
colormap(hsv(30));
MIN=980;
MAX=1040;
caxis([MIN MAX]);
assignin('base','PCOLOR_FIGURE_HANDLE1',PCOLOR_FIGURE_HANDLE1);
assignin('base','PCOLOR_FIGURE_HANDLE2',PCOLOR_FIGURE_HANDLE2);
axes(handles.axes2);

title('Thickness between lower layers - Symmetry analysis')
hold on
PCOLOR_FIGURE_HANDLE5=pcolor(lat,lon,data/100);shading interp
assignin('base','PCOLOR_FIGURE_HANDLE5',PCOLOR_FIGURE_HANDLE5);
axis([min(min(lat)) max(max(lat)) min(min(lon)) max(max(lon))]);
PCOLOR_FIGURE_HANDLE2=plot([S.X], [S.Y],'Color','black','LineWidth',0.5);
colorbar;
hold off
function varargout = medicanes_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
maximize
pushbutton5_Callback(@pushbutton5_Callback, eventdata, handles)
listbox1_Callback(@listbox1_Callback, eventdata, handles)
%% USER-DEFINED FUNCTIONS
function initial_function(~, eventdata, handles)
set(handles.text6,'String','WORKING');drawnow;
load('Europe.mat')
assignin('base','S',S);
% evalin('base','clearvars -except S RGB MyListOfDirs INITIAL cmap_m cmap_l cmap_h cmap_blue_white_red')
INITIAL=evalin('base','INITIAL');
Infolder = dir(char(fullfile(INITIAL,'\*.grb')));
MyListOfFiles = [];
for i = 1:length(Infolder)
    if Infolder(i).isdir==0
        MyListOfFiles{end+1,1} = Infolder(i).name;
    end
end
assignin('base','MyListOfFiles',MyListOfFiles);
evalin('base','clear CC3');
CC3={};
for i=1:numel(MyListOfFiles)
    file=char(MyListOfFiles{i,1});
    [CC31]=read_contents(INITIAL,file);
    CC3=[CC31;CC3];
end
[CC3]=change_names(CC3);
% remove fields besides Geopotential and MSLP
check1=strcmp(CC3(:,4),'MSL Pressure');
check2=strcmp(CC3(:,4),'GeoDynamic Height');
check=check1|check2;
CC3(~check,:)=[];
%
evalin( 'base', 'clear lat' );
evalin( 'base', 'clear lon' );
evalin( 'base', 'clear data' );
assignin('base','CC3',CC3);
set(handles.text6,'String','READY');drawnow;
function plotting(hObject, eventdata, handles)
set(handles.text6,'String','WORKING');drawnow;
RADIUS=str2num(get(handles.edit14,'String'));

A=get(handles.listbox1, 'Value');
B=get(handles.listbox1, 'String');
CC3=evalin('base','CC3');
stringToCheck = B(A);
member=find(strcmp(stringToCheck,CC3(:,18)));
CC5=CC3(member,:);
CC5=sortrows(CC5,[17,18]);
Q1=strcmp(CC5(:,4),'GeoDynamic Height');
Q2=strcmp(CC5(:,4),'MSL Pressure');
QQ=logical(Q1+Q2);
CC5=CC5(QQ,:);
CC5=sortrows(CC5,[7]);
assignin('base','CC5',CC5); %this has all the pressure levels
temp=cell2mat(CC5(:,7));
qwe3=str2double(get(handles.edit1, 'String'));
qwe2=str2double(get(handles.edit2, 'String'));
qwe1=str2double(get(handles.edit3, 'String'));
Q=temp==0|temp==qwe1 | temp==qwe2 |temp==qwe3;
CC55=CC5(Q,:);
assignin('base','CC55',CC55); %this has the info for B and Vt calculations based on edit boxes
% timestamp=CC55{1,18};
axes(handles.axes1);
IDX=str2double(char(CC55(1,1)));
IDX2=char(CC55(1,16));
assignin('base','IDX2',IDX2);
assignin('base','IDX',IDX);
[lat,lon,data]=read_grib1_time(IDX, IDX2);
AS3=get(handles.axes1);
[MINMAX_X]=AS3.XLim;
[MINMAX_Y]=AS3.YLim;
assignin('base','AS3',AS3);
[MINMAX_X(1,2) MINMAX_X(1,1) MINMAX_Y(1,2) MINMAX_Y(1,1)];
lat(lat>MINMAX_X(1,2))=nan;
lat(lat<MINMAX_X(1,1))=nan;
lon(lon>MINMAX_Y(1,2))=nan;
lon(lon<MINMAX_Y(1,1))=nan;
A1=isnan(lat);
A2=isnan(lon);
A3=A1+A2;
A3(A3>0)=1;
A3=logical(A3);
data(A3)=nan;
try
    PCOLOR_FIGURE_HANDLE1=evalin('base','PCOLOR_FIGURE_HANDLE1');
    PCOLOR_FIGURE_HANDLE1.CData = data/100;
    
catch
end
for j=1:numel(CC55(:,1))
    IDX=str2double(char(CC55(j,1)));
    IDX2=char(CC55(j,16));
    assignin('base','IDX2',IDX2);
    assignin('base','IDX',IDX);
    % find minimum
    [lat,lon,data]=read_grib1_time(IDX, IDX2);
    AS3=get(handles.axes1);
    [MINMAX_X]=AS3.XLim;
    [MINMAX_Y]=AS3.YLim;
    assignin('base','AS3',AS3);
    [MINMAX_X(1,2) MINMAX_X(1,1) MINMAX_Y(1,2) MINMAX_Y(1,1)];
    lat(lat>MINMAX_X(1,2))=nan;
    lat(lat<MINMAX_X(1,1))=nan;
    lon(lon>MINMAX_Y(1,2))=nan;
    lon(lon<MINMAX_Y(1,1))=nan;
    A1=isnan(lat);
    A2=isnan(lon);
    A3=A1+A2;
    A3(A3>0)=1;
    A3=logical(A3);
    data(A3)=nan;
    if j==1 % to kanoume mono gia na vroume tyo kentro sto msl
        m1=lat(find(data==min(min(data))));
        m2=lon(find(data==min(min(data))));
        m3=data(find(data==min(min(data))));
        m1=mean(m1);
        m2=mean(m2);
        UNITS=char(CC5(j,15));
        if strcmp(UNITS,'[Pa]')
            m3=0;
        else
            m3=mean(m3);
        end
        lonnew_current=m2;
        latnew_current=m1;
        o=sqrt((lon-lonnew_current).^2 + (lat -latnew_current).^2)    ;
        o(o>RADIUS)=nan;
        OUT=isnan(o);
    elseif j==2
        z300=data;
    elseif j==3
        z600=data;
    elseif j==4
        z900=data;
    end
    z300(OUT)=nan;
    z600(OUT)=nan;
    z900(OUT)=nan;
end
try
    axes(handles.axes2);
    data=(z600-z900)/9.81;
    axis([MINMAX_X(1,1) MINMAX_X(1,2) MINMAX_Y(1,1) MINMAX_Y(1,2)]);
    PCOLOR_FIGURE_HANDLE5=evalin('base','PCOLOR_FIGURE_HANDLE5');
    PCOLOR_FIGURE_HANDLE5.CData = data;
    colormap(hsv(30));
    MIN=min(min(data));
    MAX=max(max(data));
    caxis([MIN MAX]);
catch
end
for j=2:numel(CC5(:,1))
    IDX=str2double(char(CC5(j,1)));
    IDX2=char(CC5(j,16));
    assignin('base','IDX2',IDX2);
    assignin('base','IDX',IDX);
    [lat,lon,data]=read_grib1_time(IDX, IDX2);
    AS3=get(handles.axes1);
    [MINMAX_X]=AS3.XLim;
    [MINMAX_Y]=AS3.YLim;
    assignin('base','AS3',AS3);
    [MINMAX_X(1,2) MINMAX_X(1,1) MINMAX_Y(1,2) MINMAX_Y(1,1)];
    lat(lat>MINMAX_X(1,2))=nan;
    lat(lat<MINMAX_X(1,1))=nan;
    lon(lon>MINMAX_Y(1,2))=nan;
    lon(lon<MINMAX_Y(1,1))=nan;
    A1=isnan(lat);
    A2=isnan(lon);
    A3=A1+A2;
    A3(A3>0)=1;
    A3=logical(A3);
    data(A3)=nan;
    lonnew_current=m2;
    latnew_current=m1;
    o=sqrt((lon-lonnew_current).^2 + (lat -latnew_current).^2)    ;
    o(o>RADIUS)=nan;
    OUT=isnan(o);
    data(OUT)=nan;
    dzU(1,j)=(max(max(data))-min(min(data)));
    dzU(2,j)=cell2mat(CC5(j,7));
end
axes(handles.axes3);
PCOLOR_FIGURE_HANDLE6=plot(dzU(1,2:end)/9.81,dzU(2,2:end),'-o');
set(gca,'YDir','reverse')
xlim([0 400])
ylim([100 1000])
grid on
ylabel('hPa')
xlabel('dZ')
title('Slope of the vertical profile of dZ')
dzUA=((max(max(z300))-min(min(z300)))-(max(max(z600))-min(min(z600))))/9.81; % me ta megista
dlnpu=(log(qwe3)-log(qwe2));
VTU=dzUA/dlnpu;
dzLA=((max(max(z600))-min(min(z600)))-(max(max(z900))-min(min(z900))))/9.81;  % me ta megista
dlnpl=(log(qwe2)-log(qwe1));
VTL=dzLA/dlnpl;
[VTL VTU];
axes(handles.axes4);
plot(VTL,VTU,'-ro');
xlim([-300 300])
ylim([-500 500])
grid on
h2 = line([0 0],[-500  500],'linestyle','-');
set(h2,'LineWidth',3);
h2 = line([-300 300],[0 0],'linestyle','-');
set(h2,'LineWidth',3);
ylabel('-V^T_U')
xlabel('-V^T_L')
title('Phase diagram -V^T_U VS -V^T_L')
% find the next, in order to evaluate B
plotting_next(@plotting_next, eventdata, handles);
lonnew_next=evalin('base','lonnew_next');
latnew_next=evalin('base','latnew_next');
a1=(lonnew_next-lonnew_current)/(latnew_next-latnew_current);
b1=lonnew_next-latnew_current*a1;
theta = (0:.01:pi)+atand(a1)*pi/180;
y = RADIUS*exp(1j*theta);
xx=[imag(y)+lonnew_current ];
yy=[real(y)+latnew_current ];
lat=evalin('base','lat');
lon=evalin('base','lon');
lon(OUT)=nan;
lat(OUT)=nan;
xxq=lon(:);
yyq=lat(:);
[in,on] = inpolygon(xxq,yyq,xx,yy);
lat_left=[yyq(in);yyq(on)];
lon_left=[xxq(in);xxq(on)];
dz=(z300-z600);
dz_in=[dz(in);dz(on)];
RESULT_left_upper=nanmean(dz_in);
dz=(z600-z900);
dz_in=[dz(in);dz(on)];
RESULT_left_lower=nanmean(dz_in);
theta = theta +pi;
y = RADIUS*exp(1j*theta);
xx=[imag(y)+lonnew_current ];
yy=[real(y)+latnew_current ];
lat=evalin('base','lat');
lon=evalin('base','lon');
lon(OUT)=nan;
lat(OUT)=nan;
xxq=lon(:);
yyq=lat(:);
[in,on] = inpolygon(xxq,yyq,xx,yy);
lat_right=[yyq(in);yyq(on)];
lon_right=[xxq(in);xxq(on)];
assignin('base','lat_right',lat_right);
assignin('base','lon_right',lon_right);
dz=(z300-z600);
dz_in=[dz(in);dz(on)];
RESULT_right_upper=nanmean(dz_in);
dz=(z600-z900);
dz_in=[dz(in);dz(on)];
RESULT_right_lower=nanmean(dz_in);
if a1>0
    if (lonnew_next-lonnew_current)<0
        aa1='-';
    elseif (lonnew_next-lonnew_current)>=0
        aa1='+';
    end
elseif a1<0
    if (lonnew_next-lonnew_current)<0
        aa1='+';
    elseif (lonnew_next-lonnew_current)>=0
        aa1='-';
    end
elseif a1==0
    aa1='0';
end

if aa1=='+'
elseif aa1=='-'
    t1=RESULT_right_upper;
    t2=RESULT_left_upper;
    RESULT_right_upper=t2;
    RESULT_left_upper=t1;
    
    t1=RESULT_right_lower;
    t2=RESULT_left_lower;
    RESULT_right_lower=t2;
    RESULT_left_lower=t1;
end
axes(handles.axes6);
plot(VTL,(RESULT_right_lower - RESULT_left_lower),'-ro');
xlim([-300 300])
ylim([-500 500])
grid on
h2 = line([0 0],[-500  500],'linestyle','-');
set(h2,'LineWidth',3);
h2 = line([-300 300],[0 0],'linestyle','-');
set(h2,'LineWidth',3);
ylabel('B_L')
xlabel('-V^T_L')
title('Phase diagram B_L VS -V^T_L')

axes(handles.axes2);
try
    SEPER=evalin('base','SEPER');
    hh1=evalin('base','hh1');
    hh2=evalin('base','hh2');
    hh3=evalin('base','hh3');
    delete(SEPER);
    delete(hh1);
    delete(hh2);
    delete(hh3);
catch
end
hold on
SEPER=scatter(lat_right,lon_right,2,[0 0 1],'filled');
hh1=text(double(mean(lat_right)),double(mean(lon_right)),char(string(round(RESULT_right_lower/9.81))));
hh2=text(double(mean(lat_left)),double(mean(lon_left)),char(string(round(RESULT_left_lower/9.81))));
hh3=text(double(latnew_current+2),double(lonnew_current+2),char(string(round(RESULT_right_lower/9.81-RESULT_left_lower/9.81))),'Color','red','FontSize',14);
assignin('base','SEPER',SEPER);
assignin('base','hh1',hh1);
assignin('base','hh2',hh2);
assignin('base','hh3',hh3);
set(SEPER,'LineWidth',2);
hold off
set(handles.edit7,'String',mat2str(round(10*(RESULT_right_lower - RESULT_left_lower)/9.81)/10))
set(handles.edit8,'String',mat2str(round(10*VTL)/10))
set(handles.edit9,'String',mat2str(round(10*VTU)/10))
plotsave(@plotsave, eventdata, handles)
set(handles.text6,'String','READY');drawnow;
function plotting_next(hObject, eventdata, handles)
A=get(handles.listbox1,'Value');
B=get(handles.listbox1,'String');
if A<numel(B)
    set(handles.listbox1,'Value',A+1);
end
A=get(handles.listbox1, 'Value');
B=get(handles.listbox1, 'String');
CC3=evalin('base','CC3');
stringToCheck = B(A);
member=find(strcmp(stringToCheck,CC3(:,18)));
CC5=CC3(member,:);
CC5=sortrows(CC5,[17,18]);
Q1=strcmp(CC5(:,4),'GeoDynamic Height');
Q2=strcmp(CC5(:,4),'MSL Pressure');
QQ=logical(Q1+Q2);
CC5=CC5(QQ,:);
assignin('base','CC5',CC5); %this has all the pressure levels
temp=cell2mat(CC5(:,7));
qwe3=str2double(get(handles.edit1, 'String'));
qwe2=str2double(get(handles.edit2, 'String'));
qwe1=str2double(get(handles.edit3, 'String'));
Q=temp==0|temp==qwe1 | temp==qwe2 |temp==qwe3;
CC55=CC5(Q,:);
assignin('base','CC55',CC55); %this has the info for B and Vt calculations based on edit boxes
timestamp=CC55{1,18};
IDX=str2double(char(CC55(1,1)));
IDX2=char(CC55(1,16));
assignin('base','IDX2',IDX2);
assignin('base','IDX',IDX);
[lat,lon,data]=read_grib1_time(IDX, IDX2);
assignin('base', 'lat', lat);
assignin('base', 'lon', lon);
AS3=get(handles.axes1);
[MINMAX_X]=AS3.XLim;
[MINMAX_Y]=AS3.YLim;
assignin('base','AS3',AS3);
[MINMAX_X(1,2) MINMAX_X(1,1) MINMAX_Y(1,2) MINMAX_Y(1,1)];
lat(lat>MINMAX_X(1,2))=nan;
lat(lat<MINMAX_X(1,1))=nan;
lon(lon>MINMAX_Y(1,2))=nan;
lon(lon<MINMAX_Y(1,1))=nan;
A1=isnan(lat);
A2=isnan(lon);
A3=A1+A2;
A3(A3>0)=1;
A3=logical(A3);
data(A3)=nan;
m1=lat(find(data==min(min(data))));
m2=lon(find(data==min(min(data))));
m3=data(find(data==min(min(data))));
m1=mean(m1);
m2=mean(m2);
UNITS=char(CC5(1,15));
if strcmp(UNITS,'[Pa]')
    m3=0;
else
    m3=mean(m3);
end
lonnew_next=m2;
latnew_next=m1;
set(handles.listbox1,'Value',A-1);
assignin('base','lonnew_next',lonnew_next);
assignin('base','latnew_next',latnew_next);
function plotsave(hObject, eventdata, handles)
set(handles.text6,'String','SAVING');drawnow;
tempo=get(handles.checkbox1,'Value');
A=get(handles.listbox1, 'Value');
B=get(handles.listbox1, 'String');
name=B(A);
if tempo==1
export_fig(strcat('Analysis_',mat2str(A),'.png'),'-m2.5')
end
%% CALLBACKS
function checkbox1_Callback(hObject, eventdata, handles)
function listbox1_Callback(hObject, eventdata, handles)
plotting(@plotting, eventdata, handles)
function edit1_Callback(hObject, eventdata, handles)
plotting(@plotting, eventdata, handles)
function edit2_Callback(hObject, eventdata, handles)
plotting(@plotting, eventdata, handles);
function edit3_Callback(hObject, eventdata, handles)
plotting(@plotting, eventdata, handles);
function edit7_Callback(hObject, eventdata, handles)
function edit8_Callback(hObject, eventdata, handles)
function edit9_Callback(hObject, eventdata, handles)
function edit10_Callback(hObject, eventdata, handles)
function edit11_Callback(hObject, eventdata, handles)
function edit12_Callback(hObject, eventdata, handles)
function edit13_Callback(hObject, eventdata, handles)
function edit14_Callback(hObject, eventdata, handles)
listbox1_Callback(@listbox1_Callback, eventdata, handles)
function pushbutton1_Callback(hObject, eventdata, handles)
A=get(handles.listbox1,'Value');
B=get(handles.listbox1,'String');
if A<numel(B)-1
    set(handles.listbox1,'Value',A+1);
    plotting(@plotting, eventdata, handles)
end
function pushbutton2_Callback(hObject, eventdata, handles)
A=get(handles.listbox1,'Value');
B=get(handles.listbox1,'String');
if A>1
    set(handles.listbox1,'Value',A-1);
    plotting(@plotting, eventdata, handles);
end
function pushbutton4_Callback(hObject, eventdata, handles)
hf=findobj('Name','Medicanes Analysis');
close(hf)
function pushbutton5_Callback(hObject, eventdata, handles)
S=str2num(get(handles.edit10,'String'));
N=str2num(get(handles.edit11,'String'));
E=str2num(get(handles.edit12,'String'));
W=str2num(get(handles.edit13,'String'));
axes(handles.axes1);
ylim([S N])
xlim([E W])
axes(handles.axes2);
ylim([S N])
xlim([E W])
%% CREATES
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit11_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
