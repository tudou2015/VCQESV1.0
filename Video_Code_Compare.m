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

videofile=[PathName, FileName];
% handles.fileLoaded = 1;
% axes(handles.axes_mpeg2_frame25_signal);
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

disp(filename);
handles.filename_frame25 = filename;
handles.PathName_frame25 = PathName;
handles.FileName_frame25 = FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_frame25_generateAll.
function pushbutton_frame25_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frame25_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'mjpeg'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.webm'];
video_out2=[filename,'_webm_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2); 

% --- Executes on button press in pushbutton_mpeg2_frame25_play.
function pushbutton_mpeg2_frame25_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame25_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% filename=handles.filename_frame25;
videofile=handles.FileName_frame25;
str_play=['ffplay ',videofile];
system(str_play);   


% --- Executes on button press in pushbutton_mp4_frame25_generate.
function pushbutton_mp4_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mp4_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame25_in=video_in;
handles.filename_frame25_out1=video_out1;
handles.filename_frame25_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame25_calculate.
function pushbutton_mp4_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame25_in;
video_out=handles.filename_frame25_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_mp4_frame25_mse,'string',mse_mean);
set(handles.edit_mp4_frame25_psnr,'string',psnr_mean);
set(handles.edit_mp4_frame25_ssim,'string',ssim_mean);


function edit_mp4_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame25_ssim (see GCBO)
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
videofile=handles.filename_frame25_out1;
str_play=['ffplay ',videofile];
system(str_play); 


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
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mp4_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_in=video_in;
handles.filename_frame10_out1=video_out1;
handles.filename_frame10_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame10_calculate.
function pushbutton_mp4_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_in;
video_out=handles.filename_frame10_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_mp4_frame10_mse,'string',mse_mean);
set(handles.edit_mp4_frame10_psnr,'string',psnr_mean);
set(handles.edit_mp4_frame10_ssim,'string',ssim_mean);


function edit_mp4_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame10_ssim (see GCBO)
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
videofile=handles.filename_frame10_out1;
str_play=['ffplay ',videofile];
system(str_play);  


% --- Executes on button press in pushbutton_mpeg2_frame15_load.
function pushbutton_mpeg2_frame15_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame15_load (see GCBO)
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
currAxes = handles.axes_mpeg2_frame15_signal;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end

disp(filename);
handles.filename_frame15 = filename;
handles.PathName_frame15 = PathName;
handles.FileName_frame15 = FileName;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_frame15_generateAll.
function pushbutton_frame15_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frame15_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'mjpeg'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.webm'];
video_out2=[filename,'_webm_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2); 


% --- Executes on button press in pushbutton_mpeg2_frame15_play.
function pushbutton_mpeg2_frame15_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame15_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
videofile=handles.FileName_frame15;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_mp4_frame15_generate.
function pushbutton_mp4_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 15 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mp4_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame15_in=video_in;
handles.filename_frame15_out1=video_out1;
handles.filename_frame15_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mp4_frame15_calculate.
function pushbutton_mp4_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mp4_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_in;
video_out=handles.filename_frame15_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_mp4_frame15_mse,'string',mse_mean);
set(handles.edit_mp4_frame15_psnr,'string',psnr_mean);
set(handles.edit_mp4_frame15_ssim,'string',ssim_mean);


function edit_mp4_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp4_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mp4_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_mp4_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_mp4_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp4_frame15_ssim (see GCBO)
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
videofile=handles.filename_frame15_out1;
str_play=['ffplay ',videofile];
system(str_play);  


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
video_in=[filename,'.mp4'];
video_out1=[filename,'_h264.mp4'];
video_out2=[filename,'_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec h264 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'mjpeg'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 

video_in=[filename,'.mp4'];
video_out1=[filename,'.webm'];
video_out2=[filename,'_webm_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 10 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2); 


% --- Executes on button press in pushbutton_mpeg2_frame10_play.
function pushbutton_mpeg2_frame10_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mpeg2_frame10_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
videofile=handles.FileName_frame10;
str_play=['ffplay ',videofile];
system(str_play); 


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
handles.filename_frame10_in=video_in;
handles.filename_frame10_out1=video_out1;
handles.filename_frame10_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame10_calculate.
function pushbutton_mjpeg_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_in;
video_out=handles.filename_frame10_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame10_out2;;
str_play=['ffplay ',videofile];
system(str_play); 


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
handles.filename_frame15_in=video_in;
handles.filename_frame15_out1=video_out1;
handles.filename_frame15_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame15_calculate.
function pushbutton_mjpeg_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_in;
video_out=handles.filename_frame15_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame15_out2;;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_mjpeg_frame25_generate.
function pushbutton_mjpeg_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

video_in=[filename,'.mp4'];
video_out1=[filename,'_mjpeg.mp4'];
video_out2=[filename,'_mjpeg_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec mjpeg -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_mjpeg_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame25_in=video_in;
handles.filename_frame25_out1=video_out1;
handles.filename_frame25_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_mjpeg_frame25_calculate.
function pushbutton_mjpeg_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mjpeg_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame25_in;
video_out=handles.filename_frame25_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame25_out2;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_hevc_frame10_generate.
function pushbutton_hevc_frame10_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame10_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame10;

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
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
handles.filename_frame10_in=video_in;
handles.filename_frame10_out1=video_out1;
handles.filename_frame10_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame10_calculate.
function pushbutton_hevc_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_in;
video_out=handles.filename_frame10_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame10_out2;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_hevc_frame15_generate.
function pushbutton_hevc_frame15_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame15_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame15;

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
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
handles.filename_frame15_in=video_in;
handles.filename_frame15_out1=video_out1;
handles.filename_frame15_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame15_calculate.
function pushbutton_hevc_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_in;
video_out=handles.filename_frame15_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
%     disp(size(image1));
%     disp(size(image2));
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame15_out2;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_hevc_frame25_generate.
function pushbutton_hevc_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

video_in=[filename,'.mp4'];
video_out1=[filename,'.hevc'];
video_out2=[filename,'_hevc_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec hevc -r 25 ',video_out1];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out2);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_hevc_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame25_in=video_in;
handles.filename_frame25_out1=video_out1;
handles.filename_frame25_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_hevc_frame25_calculate.
function pushbutton_hevc_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hevc_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame25_in;
video_out=handles.filename_frame25_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
videofile=handles.filename_frame25_out2;
str_play=['ffplay ',videofile];
system(str_play); 


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
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpegts -r 10 ',video_out2];
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec yuv4 -r 10 ',video_out2];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 10 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_webm_frame10_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame10_in=video_in;
handles.filename_frame10_out1=video_out1;
handles.filename_frame10_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame10_calculate.
function pushbutton_webm_frame10_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame10_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame10_in;
video_out=handles.filename_frame10_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_webm_frame10_mse,'string',mse_mean);
set(handles.edit_webm_frame10_psnr,'string',psnr_mean);
set(handles.edit_webm_frame10_ssim,'string',ssim_mean);


function edit_webm_frame10_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame10_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame10_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame10_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame10_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame10_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame10_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame10_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame10_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame10_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame10_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame10_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame10_ssim (see GCBO)
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
videofile=handles.filename_frame10_out1;
str_play=['ffplay ',videofile];
system(str_play); 


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
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpegts -r 10 ',video_out2];
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec yuv4 -r 10 ',video_out2];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 15 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_webm_frame15_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame15_in=video_in;
handles.filename_frame15_out1=video_out1;
handles.filename_frame15_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame15_calculate.
function pushbutton_webm_frame15_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame15_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame15_in;
video_out=handles.filename_frame15_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_webm_frame15_mse,'string',mse_mean);
set(handles.edit_webm_frame15_psnr,'string',psnr_mean);
set(handles.edit_webm_frame15_ssim,'string',ssim_mean);


function edit_webm_frame15_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame15_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame15_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame15_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame15_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame15_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame15_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame15_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame15_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame15_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame15_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame15_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame15_ssim (see GCBO)
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
videofile=handles.filename_frame15_out1;
str_play=['ffplay ',videofile];
system(str_play); 


% --- Executes on button press in pushbutton_webm_frame25_generate.
function pushbutton_webm_frame25_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame25_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename_frame25;

video_in=[filename,'.mp4'];
video_out1=[filename,'_vp9.webm'];
video_out2=[filename,'_vp9_mpeg2.mp4'];
str_out1= ['ffmpeg -i ',video_in,' -vcodec vp9 -r 25 ',video_out1];
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpegts -r 10 ',video_out2];
% str_out2= ['ffmpeg -i ',video_out1,' -vcodec yuv4 -r 10 ',video_out2];
str_out2= ['ffmpeg -i ',video_out1,' -vcodec mpeg2video -r 25 ',video_out2];
system(str_out1);   
system(str_out2);  

v = VideoReader(video_out1);
disp(v.FrameRate);
disp(v);
currAxes = handles.axes_webm_frame25_video;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
handles.filename_frame25_in=video_in;
handles.filename_frame25_out1=video_out1;
handles.filename_frame25_out2=video_out2;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_webm_frame25_calculate.
function pushbutton_webm_frame25_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webm_frame25_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video_in=handles.filename_frame25_in;
video_out=handles.filename_frame25_out2;
disp(video_in);
disp(video_out);
% formats = VideoReader.getFileFormats();
% disp(formats);
    
v_out = VideoReader(video_out);
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
    image1=image1(13:(end-12),:,:);
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
set(handles.edit_webm_frame25_mse,'string',mse_mean);
set(handles.edit_webm_frame25_psnr,'string',psnr_mean);
set(handles.edit_webm_frame25_ssim,'string',ssim_mean);


function edit_webm_frame25_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame25_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame25_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame25_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame25_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame25_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame25_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame25_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_webm_frame25_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webm_frame25_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_webm_frame25_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_webm_frame25_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webm_frame25_ssim (see GCBO)
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
videofile=handles.filename_frame25_out1;
str_play=['ffplay ',videofile];
system(str_play); 
