function varargout = Video_Code_Compare(varargin)
% VIDEO_CODE_COMPARE MATLAB code for Video_Code_Compare.fig
%      VIDEO_CODE_COMPARE, by itself, creates a new VIDEO_CODE_COMPARE or raises the existing
%      singleton*.
%
%      H = VIDEO_CODE_COMPARE returns the handle to a new VIDEO_CODE_COMPARE or the handle to
%      the existing singleton*.
%
%      VIDEO_CODE_COMPARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIDEO_CODE_COMPARE.M with the given input arguments.
%
%      VIDEO_CODE_COMPARE('Property','Value',...) creates a new VIDEO_CODE_COMPARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Video_Code_Compare_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Video_Code_Compare_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Video_Code_Compare

% 赛尔网络下一代互联网技术创新项目(NGII20180502)

% Modified by hankun,zhangwensheng v1.0 11-Nov-2021 10:23:12
% Last Modified by hankun,zhangwensheng v1.0 15-Dec-2021 09:52:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Video_Code_Compare_OpeningFcn, ...
                   'gui_OutputFcn',  @Video_Code_Compare_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Video_Code_Compare is made visible.
function Video_Code_Compare_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Video_Code_Compare (see VARARGIN)

% Choose default command line output for Video_Code_Compare
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Video_Code_Compare wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Video_Code_Compare_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_mpeg2_frame25_load.
function pushbutton_mpeg2_frame25_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame25_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.mp4'},'Load Mp4 File');
filename=FileName(1:end-4);
disp(filename);

% sss = ['00:00:55','00:01:22','00:00:17','00:01:30','00:00:38'];
num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

% video_rate_frame25 = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
% disp(video_rate_frame25);
rates = [1000 900 800 700 600 500 400 300 200 100];
% rates = [300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

% video_in=[PathName,filename,'.mp4'];
% video_out_mpeg2=[filename,'_mpeg2_bv1000k.mp4'];
% str_out_mpeg2= ['ffmpeg -i ',video_in,' -c:v mpeg2video -b:v 1000k -minrate 1000k -maxrate 1000k -bufsize 1000k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out_mpeg2];
% system(str_out_mpeg2);

codec='mpeg2video';
video_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);   

videofile=[video_out1];
% handles.fileLoaded = 1;
v = VideoReader(videofile);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mpeg2_frame25_signal;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

outfile='./out/result_frame25.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    newCell_title={'filename','codec',...
        'filesiez','vr','rr','mse','psnr','ssim'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

handles.filename_frame25_outfile=outfile;
handles.filename_frame25_vr=vr;
handles.filename_frame25_rr=rr;
handles.filename_frame25 = filename;
handles.PathName_frame25 = PathName;
handles.FileName_frame25 = FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_frame25_generateAll.
function pushbutton_frame25_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frame25_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

% video_in=[filename,'.mp4'];
% video_out1=[filename,'_bv',vr,'k_h264.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];

codec='h264';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1);   

v = VideoReader(file_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

codec='mjpeg';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1); 
file_out2=[file_out_path,filename2,codec,'_mpeg2.mp4'];
str_out2= ['ffmpeg -i ',file_out1,' -vcodec mpeg2video ',file_out2];
system(str_out2); 

v = VideoReader(file_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

codec='hevc';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1)

v = VideoReader(file_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

codec='vp9';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1)
% file_out2=[file_out_path,filename2,codec,'_mpeg2.mp4'];
% str_out2= ['ffmpeg -i ',file_out1,' -vcodec mpeg2video ',file_out2];
% system(str_out2);

v = VideoReader(file_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

% handles.filename_frame25_codec=codec;
handles.filename_frame25_vr=vr;
handles.filename_frame25_rr=rr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mpeg2_frame25_play.
function pushbutton_mpeg2_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
% rates = [300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

codec='mpeg2video';
file_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out_path=['video_',codec,'_out/'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% file_out1=[filename,'_bv1000k_h264.mp4'];
% file_out2=[filename,'_bv1000k_mpeg2video.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);   


% --- Executes on button press in pushbutton_mp4_frame25_generate.
 
% hObject    handle to pushbutton_mp4_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

% video_in=[filename,'.mp4'];
% video_out1=[filename,'_bv',vr,'k_h264.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];

codec='h264';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1);   

v = VideoReader(file_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

handles.filename_frame25_codec=codec;
handles.filename_frame25_vr=vr;
handles.filename_frame25_rr=rr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame25_calculate.
function pushbutton_mp4_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='h264';

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

codec='h264';
filename_in=[filename,'_bv','1000','k_rr',rr,'_mpeg2video'];
% filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
% mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
disp(file_in);
disp(file_out1);

[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
fs = ftell(fid); 
disp(fs);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(file_out1);
disp(v_out);
v_in = VideoReader(file_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);

% 存入文件
% codec,fs,vr,mse,psnr,ssim
% h264,
outfile=handles.filename_frame25_outfile;
newCell_title={'filename','codec',...
    'filesiez','vr','rr','mse','psnr','ssim'};

newCell_zhi={filename,codec,...
            fs,vr,rr,mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);

newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;

newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_h264_frame25_mse,'string',mse_mean);
set(handles.edit_h264_frame25_psnr,'string',psnr_mean);
set(handles.edit_h264_frame25_ssim,'string',ssim_mean);


function edit_h264_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h264_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h264_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mp4_frame25_play.
function pushbutton_mp4_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% videofile=handles.FileName_frame25;
filename=handles.filename_frame25;
codec='h264';

rates = [1000 900 800 700 600 500 400 300 200 100];
% rates = [300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

% codec='mpeg2video';
file_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out_path=['video_',codec,'_out/'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mp4_frame10_generate.
function pushbutton_mp4_frame10_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame10_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;

video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_h264_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_h264_in=video_in;
handles.filename_frame10_h264_out1=video_out1;
handles.filename_frame10_h264_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame10_calculate.
function pushbutton_mp4_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_h264_in;
video_out1=handles.filename_frame10_h264_out1;
video_out2=handles.filename_frame10_h264_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_h264_frame10_mse,'string',mse_mean);
set(handles.edit_h264_frame10_psnr,'string',psnr_mean);
set(handles.edit_h264_frame10_ssim,'string',ssim_mean);


function edit_h264_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h264_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h264_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mp4_frame10_play.
function pushbutton_mp4_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
file_in=[filename,'.mp4'];
file_out1=[filename,'_h264.mp4'];
file_out2=[filename,'_h264_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_mpeg2_frame15_load.
function pushbutton_mpeg2_frame15_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame15_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.mp4'},'Load Mp4 File');
filename=FileName(1:end-4);

num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

rates = [1000 300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame15, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [15 10 5 1];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame15_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

codec='mpeg2video';
video_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);   

% videofile=[PathName, FileName];
videofile=[video_out1];
% handles.fileLoaded = 1;
v = VideoReader(videofile);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mpeg2_frame15_signal;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

outfile='./out/result_frame15.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    newCell_title={'filename','codec',...
        'filesiez','vr','rr','mse','psnr','ssim'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

handles.filename_frame15_outfile=outfile;
handles.filename_frame15_vr=vr;
handles.filename_frame15_rr=rr;
handles.filename_frame15 = filename;
handles.PathName_frame15 = PathName;
handles.FileName_frame15 = FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_frame15_generateAll.
function pushbutton_frame15_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frame15_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

rates = [300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame15, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [20 15 10 5 1];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame15_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

% h264
codec='h264';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
video_in=['video_mpeg2video_out/',filename_in,'.mp4'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

% mjpeg
codec='mjpeg';
video_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1); 
video_out2=[video_out_path,filename2,codec,'_mpeg2.mp4'];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video ',video_out2];
system(str_out2); 

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

% hevc
codec='hevc';
video_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);   

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);

% vp9
codec='vp9';
video_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);   

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
% guidata(hObject, handles);


% --- Executes on button press in pushbutton_mpeg2_frame15_play.
function pushbutton_mpeg2_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

% rates = [1000 900 800 700 600 500 400 300 200 100];
rates = [1000 300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame15, 'value'));
disp(video_rate);
vr=num2str(video_rate);
disp(vr);

r_rates = [15 10 5 1];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame15_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

codec='mpeg2video';
file_in=['video/',filename,'.mp4'];
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out_path=['video_',codec,'_out/'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);   


% --- Executes on button press in pushbutton_mp4_frame15_generate.
function pushbutton_mp4_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

rates = [300 250 200 150 100 50];
video_rate = rates(get(handles.popupmenu_mpeg2_frame15, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);

r_rates = [20 15 10 5 1];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame15_rr, 'value'));
disp(rr_rate);
% video_rate=num2str(handles.video_rate_frame25);
rr=num2str(rr_rate);
disp(rr);

codec='h264';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
video_in=['video_mpeg2video_out/',filename_in,'.mp4'];
video_out_path=['video_',codec,'_out/'];
mkdir(video_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
video_out1=[video_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',video_out1];
system(str_out1);   

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

handles.filename_frame15_codec=codec;
handles.filename_frame15_vr=vr;
handles.filename_frame15_rr=rr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame15_calculate.
function pushbutton_mp4_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_h264_in;
video_out1=handles.filename_frame15_h264_out1;
video_out2=handles.filename_frame15_h264_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_h264_frame15_mse,'string',mse_mean);
set(handles.edit_h264_frame15_psnr,'string',psnr_mean);
set(handles.edit_h264_frame15_ssim,'string',ssim_mean);


function edit_h264_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_h264_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h264_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h264_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_h264_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_h264_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h264_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mp4_frame15_play.
function pushbutton_mp4_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;
file_in=[filename,'.mp4'];
file_out1=[filename,'_h264.mp4'];
file_out2=[filename,'_h264_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mpeg2_frame10_load.
function pushbutton_mpeg2_frame10_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame10_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.mp4'},'Load Mp4 File');
filename=FileName(1:end-4);

videofile=[PathName, FileName];
% handles.fileLoaded = 1;
% axes(handles.axes_mpeg2_frame25_signal);
v = VideoReader(videofile);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mpeg2_frame10_signal;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

disp(filename);
handles.filename_frame10 = filename;
handles.PathName_frame10 = PathName;
handles.FileName_frame10 = FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_frame10_generateAll.
function pushbutton_frame10_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frame10_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_h264_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_h264_in=video_in;
handles.filename_frame10_h264_out1=video_out1;
handles.filename_frame10_h264_out2=video_out2;
% guidata(hObject, handles);

video_in=[filename,'.mp4'];
video_out1=[filename,'_mjpeg.mp4'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_mjpeg_in=video_in;
handles.filename_frame10_mjpeg_out1=video_out1;
handles.filename_frame10_mjpeg_out2=video_out2;
% guidata(hObject, handles);

video_in=[filename,'.mp4'];
video_out1=[filename,'_hevc.mp4'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_hevc_in=video_in;
handles.filename_frame10_hevc_out1=video_out1;
handles.filename_frame10_hevc_out2=video_out2;
% guidata(hObject, handles);

video_in=[filename,'.mp4'];
video_out1=[filename,'_vp9.webm'];
video_out2=[filename,'_vp9_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_vp9_in=video_in;
handles.filename_frame10_vp9_out1=video_out1;
handles.filename_frame10_vp9_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mpeg2_frame10_play.
function pushbutton_mpeg2_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
file_in=[filename,'.mp4'];
file_out1=[filename,'_mpeg2.mp4'];
file_out2=[filename,'_mpeg2_mpeg2.mp4'];
str_cmd=['ffplay ',file_in];
system(str_cmd);  


% --- Executes on button press in pushbutton_mjpeg_frame10_generate.
function pushbutton_mjpeg_frame10_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame10_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;

video_in=[filename,'.mp4'];
video_out1=[filename,'_mjpeg.mp4'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec mjpeg -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_mjpeg_in=video_in;
handles.filename_frame10_mjpeg_out1=video_out1;
handles.filename_frame10_mjpeg_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame10_calculate.
function pushbutton_mjpeg_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_mjpeg_in;
video_out1=handles.filename_frame10_mjpeg_out1;
video_out2=handles.filename_frame10_mjpeg_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_mjpeg_frame10_mse,'string',mse_mean);
set(handles.edit_mjpeg_frame10_psnr,'string',psnr_mean);
set(handles.edit_mjpeg_frame10_ssim,'string',ssim_mean);


function edit_mjpeg_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mjpeg_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mjpeg_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mjpeg_frame10_play.
function pushbutton_mjpeg_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
file_in=[filename,'.mp4'];
file_out1=[filename,'_mjpeg.mp4'];
file_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_mjpeg_frame15_generate.
function pushbutton_mjpeg_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

video_in=[filename,'.mp4'];
video_out1=[filename,'_mjpeg.mp4'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec mjpeg -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame15_mjpeg_in=video_in;
handles.filename_frame15_mjpeg_out1=video_out1;
handles.filename_frame15_mjpeg_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame15_calculate.
function pushbutton_mjpeg_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_mjpeg_in;
video_out1=handles.filename_frame15_mjpeg_out1;
video_out2=handles.filename_frame15_mjpeg_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_mjpeg_frame15_mse,'string',mse_mean);
set(handles.edit_mjpeg_frame15_psnr,'string',psnr_mean);
set(handles.edit_mjpeg_frame15_ssim,'string',ssim_mean);


function edit_mjpeg_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mjpeg_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mjpeg_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mjpeg_frame15_play.
function pushbutton_mjpeg_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;
file_in=[filename,'.mp4'];
file_out1=[filename,'_mjpeg.mp4'];
file_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_mjpeg_frame25_generate.
function pushbutton_mjpeg_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);

r_rates = [25 20];
rr_rate = r_rates(get(handles.popupmenu_mpeg2_frame25_rr, 'value'));
disp(rr_rate);
rr=num2str(rr_rate);
disp(rr);

num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

% video_in=[filename,'.mp4'];
% video_out1=[filename,'_bv',vr,'k_h264.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];

codec='mjpeg';
filename_in=[filename,'_bv',vr,'k_rr',rr,'_mpeg2video'];
file_in=['video_mpeg2video_out/',filename_in,'.mp4'];
file_out_path=['video_',codec,'_out/'];
mkdir(file_out_path);
filename2=[filename,'_bv',vr,'k_rr',rr,'_'];
file_out1=[file_out_path,filename2,codec,'.mp4'];
% str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
str_out1= ['ffmpeg -i ',file_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -r ',rr,' -ac 1 -ar 16k ',file_out1];
system(str_out1);
file_out2=[file_out_path,filename2,codec,'_mpeg2.mp4'];
str_out2= ['ffmpeg -i ',file_out1,' -vcodec mpeg2video ',file_out2];
system(str_out2);  

v = VideoReader(file_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

handles.filename_frame25_codec=codec;
handles.filename_frame25_vr=vr;
handles.filename_frame25_rr=rr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame25_calculate.
function pushbutton_mjpeg_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='mjpeg';

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);
% video_rate=handles.video_rate_frame25;
filename2=[filename,'_bv',vr,'k'];
disp(video_rate);
video_in=[filename,'_mpeg2_bv1000k.mp4'];
video_out_path=['video_',codec,'_out/'];
video_out1=[video_out_path,filename2,'_mjpeg.mp4'];
video_out2=[video_out_path,filename2,'_mjpeg_mpeg2.mp4'];
disp(video_in);
disp(video_out1);
disp(video_out2);

fid=fopen(video_out1);
fseek(fid,0,'eof');
fs = ftell(fid); 
disp(fs);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);

% 存入文件
% codec,fs,vr,mse,psnr,ssim
% mjpeg,
outfile=handles.filename_frame25_outfile;
newCell_title={'filename','codec',...
    'filesiez','video_rate','mse','psnr','ssim'};

newCell_zhi={filename,codec,...
            fs,vr,mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);

newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;

newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_mjpeg_frame25_mse,'string',mse_mean);
set(handles.edit_mjpeg_frame25_psnr,'string',psnr_mean);
set(handles.edit_mjpeg_frame25_ssim,'string',ssim_mean);


function edit_mjpeg_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mjpeg_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mjpeg_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mjpeg_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mjpeg_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mjpeg_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mjpeg_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mjpeg_frame25_play.
function pushbutton_mjpeg_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='mjpeg';

vr=handles.filename_frame25_vr;
filename2=[filename,'_bv',vr,'k','_'];
file_in=[filename,'.mp4'];
video_out_path=['video_',codec,'_out/'];
file_out1=[video_out_path,filename2,codec,'.mp4'];
file_out2=[filename,'_h264_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton_hevc_frame10_generate.
function pushbutton_hevc_frame10_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame10_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;

video_in=[filename,'.mp4'];
video_out1=[filename,'_hevc.mp4'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_hevc_in=video_in;
handles.filename_frame10_hevc_out1=video_out1;
handles.filename_frame10_hevc_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame10_calculate.
function pushbutton_hevc_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_hevc_in;
video_out1=handles.filename_frame10_hevc_out1;
video_out2=handles.filename_frame10_hevc_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_hevc_frame10_mse,'string',mse_mean);
set(handles.edit_hevc_frame10_psnr,'string',psnr_mean);
set(handles.edit_hevc_frame10_ssim,'string',ssim_mean);


function edit_hevc_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hevc_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_hevc_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_hevc_frame10_play.
function pushbutton_hevc_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
file_in=[filename,'.mp4'];
file_out1=[filename,'_hevc.mp4'];
file_out2=[filename,'_hevc_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_hevc_frame15_generate.
function pushbutton_hevc_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

video_in=[filename,'.mp4'];
video_out1=[filename,'_hevc.mp4'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame15_hevc_in=video_in;
handles.filename_frame15_hevc_out1=video_out1;
handles.filename_frame15_hevc_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame15_calculate.
function pushbutton_hevc_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_hevc_in;
video_out1=handles.filename_frame15_hevc_out1;
video_out2=handles.filename_frame15_hevc_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_hevc_frame15_mse,'string',mse_mean);
set(handles.edit_hevc_frame15_psnr,'string',psnr_mean);
set(handles.edit_hevc_frame15_ssim,'string',ssim_mean);


function edit_hevc_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_hevc_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_hevc_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_hevc_frame15_play.
function pushbutton_hevc_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;
file_in=[filename,'.mp4'];
file_out1=[filename,'_hevc.mp4'];
file_out2=[filename,'_hevc_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_hevc_frame25_generate.
function pushbutton_hevc_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);
num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

video_in=[filename,'.mp4'];
video_out1=[filename,'_bv',vr,'k_hevc.mp4'];
codec='hevc';
% video_out2=[filename,'_bv',vr,'k_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
system(str_out1);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

handles.filename_frame25_codec=codec;
handles.filename_frame25_vr=vr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame25_calculate.
function pushbutton_hevc_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='hevc';

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);
% video_rate=handles.video_rate_frame25;
filename2=[filename,'_bv',vr,'k'];
disp(video_rate);
video_in=[filename,'_mpeg2_bv1000k.mp4'];
video_out_path=['video_',codec,'_out/'];
video_out1=[video_out_path,filename2,'_hevc.mp4'];
disp(video_in);
disp(video_out1);

fid=fopen(video_out1);
fseek(fid,0,'eof');
fs = ftell(fid); 
disp(fs);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out1);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);

% 存入文件
% codec,fs,vr,mse,psnr,ssim
% hevc,
outfile=handles.filename_frame25_outfile;
newCell_title={'filename','codec',...
    'filesiez','video_rate','mse','psnr','ssim'};

newCell_zhi={filename,codec,...
            fs,vr,mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);

newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;

newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_hevc_frame25_mse,'string',mse_mean);
set(handles.edit_hevc_frame25_psnr,'string',psnr_mean);
set(handles.edit_hevc_frame25_ssim,'string',ssim_mean);


function edit_hevc_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_hevc_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_hevc_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hevc_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_hevc_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_hevc_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hevc_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_hevc_frame25_play.
function pushbutton_hevc_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='hevc';

vr=handles.filename_frame25_vr;
filename2=[filename,'_bv',vr,'k','_'];
file_in=[filename,'.mp4'];
video_out_path=['video_',codec,'_out/'];
file_out1=[video_out_path,filename2,codec,'.mp4'];
file_out2=[filename,'_h264_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton_webm_frame10_generate.
function pushbutton_webm_frame10_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame10_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;

video_in=[filename,'.mp4'];
video_out1=[filename,'_vp9.webm'];
video_out2=[filename,'_vp9_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_vp9_in=video_in;
handles.filename_frame10_vp9_out1=video_out1;
handles.filename_frame10_vp9_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame10_calculate.
function pushbutton_webm_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_vp9_in;
video_out1=handles.filename_frame10_vp9_out1;
video_out2=handles.filename_frame10_vp9_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_vp9_frame10_mse,'string',mse_mean);
set(handles.edit_vp9_frame10_psnr,'string',psnr_mean);
set(handles.edit_vp9_frame10_ssim,'string',ssim_mean);


function edit_vp9_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vp9_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vp9_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_webm_frame10_play.
function pushbutton_webm_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;
file_in=[filename,'.mp4'];
file_out1=[filename,'_vp9.webm'];
file_out2=[filename,'_vp9_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_webm_frame15_generate.
function pushbutton_webm_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

video_in=[filename,'.mp4'];
video_out1=[filename,'_vp9.webm'];
video_out2=[filename,'_vp9_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame15_vp9_in=video_in;
handles.filename_frame15_vp9_out1=video_out1;
handles.filename_frame15_vp9_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame15_calculate.
function pushbutton_webm_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_vp9_in;
video_out1=handles.filename_frame15_vp9_out1;
video_out2=handles.filename_frame15_vp9_out2;
disp(video_in);
disp(video_out2);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);
set(handles.edit_vp9_frame15_mse,'string',mse_mean);
set(handles.edit_vp9_frame15_psnr,'string',psnr_mean);
set(handles.edit_vp9_frame15_ssim,'string',ssim_mean);


function edit_vp9_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vp9_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vp9_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_webm_frame15_play.
function pushbutton_webm_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;
file_in=[filename,'.mp4'];
file_out1=[filename,'_vp9.webm'];
file_out2=[filename,'_vp9_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd);  


% --- Executes on button press in pushbutton_webm_frame25_generate.
function pushbutton_webm_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);
num=get(handles.popupmenu_mpeg2_frame25_ss, 'value');
disp(num);
if num==1
    ss_t='00:00:55';
elseif num==2
    ss_t='00:01:22';
elseif num==3
    ss_t='00:00:17';
elseif num==4
    ss_t='00:01:30';
elseif num==5
    ss_t='00:00:38';
else
    ss_t='00:00:17';
end
disp(ss_t);

video_in=[filename,'.mp4'];
video_out1=[filename,'_bv',vr,'k_vp9.webm'];
codec='vp9';
% video_out2=[filename,'_bv',vr,'k_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec ',codec,' -b:v ',vr,'k -minrate ',vr,'k -maxrate ',vr,'k -bufsize ',vr,'k -s 640*360 -ss ',ss_t,' -t 2 -r 25 -ac 1 -ar 16k ',video_out1];
system(str_out1);   
video_out2=[filename,'_bv',vr,'k_vp9_mpeg2.mp4'];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_vp9_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

handles.filename_frame25_codec=codec;
handles.filename_frame25_vr=vr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame25_calculate.
function pushbutton_webm_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='vp9';

rates = [1000 900 800 700 600 500 400 300 200 100];
video_rate = rates(get(handles.popupmenu_mpeg2_frame25, 'value'));
disp(video_rate);
% video_rate=num2str(handles.video_rate_frame25);
vr=num2str(video_rate);
disp(vr);
% video_rate=handles.video_rate_frame25;
filename2=[filename,'_bv',vr,'k'];
disp(video_rate);
video_in=[filename,'_mpeg2_bv1000k.mp4'];
video_out_path=['video_',codec,'_out/'];
video_out1=[video_out_path,filename2,'_vp9.webm'];
disp(video_in);
disp(video_out1);
video_out2=[video_out_path,filename2,'_vp9_mpeg2.mp4'];
disp(video_out2);

fid=fopen(video_out1);
fseek(fid,0,'eof');
fs = ftell(fid); 
disp(fs);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out2);
disp(v_out);
v_in = VideoReader(video_in);
disp(v_in);
data_in = read(v_in); % Get both frames
data_out= read(v_out);

% disp(vid_in);
frame_num=v_in.FrameRate*v_in.Duration;
disp(frame_num);
frame_num2=v_out.FrameRate*v_out.Duration;
disp(frame_num2);
mse_=[];
psnr_=[];
ssim_=[];
for k=1:frame_num
    image1 = data_in(:,:,:,k); % The first frame
    image2 = data_out(:,:,:,k); % The second frame
    imwrite(image1,'a.bmp','bmp');
    imwrite(image2,'b.bmp','bmp');
    disp(size(image1));
    disp(size(image2));
    [c1x,c1y,c1z]=size(image1);
    [c2x,c2y,c2z]=size(image2);
    disp(['c1x=' num2str(c1x) ]);
    disp(['c2x=' num2str(c2x) ]);
    deltx=(c1x-c2x)/2;
    image1=image1((deltx+1):(end-deltx),:,:);
    er=double(image1-image2).^2;
    su = sum(sum(er)); 
    si= size(image1,1)*size(image1,2)*size(image1,3);
    dsi=double(si);
    mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
    if (mse==0)
        psnr=100;
    else
        psnr = 10.0 * log10((255 * 255) / mse);
    end
    % ssim=getMSSIM(image1,image2);
    cmd=['psnr 296 144 420 ','a.bmp',' ','b.bmp',' ssim ','>ab.txt'];
    system(cmd);
    ab=textread('ab.txt','%s');
    ssim=str2num(ab{1});
    disp(ssim);
    % 数组赋值
    mse_(1,k)=mse;
    psnr_(1,k)=psnr;
    ssim_(1,k)=ssim;
end
disp(mse_(1,:));
disp(psnr_(1,:));
disp(ssim_(1,:));
mse_mean=mean(mse_(1,:));
psnr_mean=mean(psnr_(1,:));
ssim_mean=mean(ssim_(1,:));
disp(mse_mean);
disp(psnr_mean);
disp(ssim_mean);

% 存入文件
% codec,fs,vr,mse,psnr,ssim
% vp9,
outfile=handles.filename_frame25_outfile;
newCell_title={'filename','codec',...
    'filesiez','video_rate','mse','psnr','ssim'};

newCell_zhi={filename,codec,...
            fs,vr,mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);

newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;

newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_vp9_frame25_mse,'string',mse_mean);
set(handles.edit_vp9_frame25_psnr,'string',psnr_mean);
set(handles.edit_vp9_frame25_ssim,'string',ssim_mean);


function edit_vp9_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vp9_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vp9_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vp9_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_vp9_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_vp9_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vp9_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_webm_frame25_play.
function pushbutton_webm_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;
codec='vp9';

vr=handles.filename_frame25_vr;
filename2=[filename,'_bv',vr,'k','_'];
file_in=[filename,'.mp4'];
video_out_path=['video_',codec,'_out/'];
file_out1=[video_out_path,filename2,codec,'.webm'];
file_out2=[filename,'_h264_mpeg2.mp4'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame25.
function popupmenu_mpeg2_frame25_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame25 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame25


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame25_ss.
function popupmenu_mpeg2_frame25_ss_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame25_ss contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame25_ss


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame25_ss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame10.
function popupmenu_mpeg2_frame10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame10


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame10_rr.
function popupmenu_mpeg2_frame10_rr_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame10_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame10_rr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame10_rr


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame10_rr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame10_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame15.
function popupmenu_mpeg2_frame15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame15


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame15_rr.
function popupmenu_mpeg2_frame15_rr_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame15_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame15_rr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame15_rr


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame15_rr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame15_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_mpeg2_frame25_rr.
function popupmenu_mpeg2_frame25_rr_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mpeg2_frame25_rr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mpeg2_frame25_rr


% --- Executes during object creation, after setting all properties.
function popupmenu_mpeg2_frame25_rr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mpeg2_frame25_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
