function varargout = Fruit_Detection_System(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fruit_Detection_System_OpeningFcn, ...
                   'gui_OutputFcn',  @Fruit_Detection_System_OutputFcn, ...
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




% --- Executes just before Fruit_Detection_System is made visible.
function Fruit_Detection_System_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fruit_Detection_System (see VARARGIN)
axes(handles.axes3);
imshow('new_BG_Image.jpg');



% axes(handles.axes3);
% imshow('photo2.jpg');


% Choose default command line output for Fruit_Detection_System
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);

% UIWAIT makes Fruit_Detection_System wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fruit_Detection_System_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[a, b] = uigetfile('*.jpg');
x1 = strcat(b, a);
x1 = imread(x1);
axes(handles.axes4);
imshow(x1);
handles.x1 = x1;

% Update handles structure

guidata(hObject, handles);








% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%imshow('photo2.jpg');

y = handles.x1;

axes(handles.axes5);
%
GRAY_SCALE_IMAGE = rgb2gray(y);                    %convert rgb image to gray scale image
%
DISK_MASK = strel('disk',5);                       %create a disk type filter;
%
MASKED_IMAGE = imerode(GRAY_SCALE_IMAGE,DISK_MASK);%add mask
%
BLACK_AND_WHITE = MASKED_IMAGE < 85;              %convert gray scale image to black and white image
%
imshow(y);
pause(0.5);
%
imshow(GRAY_SCALE_IMAGE);
pause(0.5);
%
imshow(MASKED_IMAGE);
pause(0.5);
%
imshow(BLACK_AND_WHITE);
pause(0.5);
%
imshow(y);
pause(0.5);
title('Surface Detected!');

[a b] = bwlabel(BLACK_AND_WHITE);                   %count number of objects
C = b - 1;
  
if C <= 2
    set(handles.status_quality, 'String', 'Good!');
    set(handles.status_quality, 'Background', [0.275 0.424 1.0]);
    set(handles.status_quality, 'Foreground', 'white');          
      
else
    set(handles.status_quality, 'String', 'Damaged!');
    set(handles.status_quality, 'Background', [0.275 0.424 1.0]);
    set(handles.status_quality, 'Foreground', 'white'); 
   % msgbox('Damaged Fruit Detected! ')
    pause(0.2);
    %closereq();


end


%%%%%%%%%%%%%%================= MAHELA ================%%%%%%%%%%%%%%%%%%


if C <= 2
  set(handles.surfacequality, 'String', 'Pass');
  set(handles.surfacequality, 'Background', [0.0 0.957 0.239]);
  set(handles.surfacequality, 'Foreground', 'white');         
      
else
    set(handles.surfacequality, 'String', 'Fail');
    set(handles.surfacequality, 'Background', [1.0 0.0 0.0]);
    set(handles.surfacequality, 'Foreground', 'white'); 
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%===================Rajitha's CODE=========================
function output = pushbutton3_Callback(hObject, eventdata, handles)

x = handles.x1;
axes(handles.axes6)
imshow(x);

xi= size(x, 1)/2;
yi=size(x, 2)/2;

%Celect pixel to detect
u=impixel(x,xi,yi);
a=u(1,1);
b=u(1,2);
c=u(1,3);

%Color detec function
if (a<10 && b<10 && c>120 && c<160 )
   
    set(handles.colordet,'string','Blue Apple');
    
elseif(a<=210 && b<50 && c<60 )
   
    set(handles.colordet,'string','Red Apple');
    set(handles.colordet, 'Background', [1.0 0.0 0.0]);
    set(handles.colordet, 'Foreground', 'white');
    output = 1;
  
elseif(a<=185 && b<=255 && c<=170 )
   
    set(handles.colordet,'string','Green Apple');
    set(handles.colordet, 'Background', [0.0 0.957 0.239]);
    set(handles.colordet, 'Foreground', 'white');
    output = 2;
    
elseif(a>=235 && b<=160 && b>120 && c<80 && c>20 )
   
    set(handles.colordet,'string','Orange');
    set(handles.colordet, 'Background', [1.0 0.698 0.027]);
    set(handles.colordet, 'Foreground', 'white');
    output = 1;
    
else  
     set(handles.colordet,'string','Not Detect');
     
end 

%%%%%%%%%%%%%%%%%%%%%%% MAHELA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Statustext2

if (a<10 && b<10 && c>120 && c<160 )
   
    set(handles.colorquality,'string','Pass ');
    set(handles.colorquality, 'Background', [0.0 0.957 0.239]);
    set(handles.colorquality, 'Foreground', 'white'); 
    
elseif(a<=210 && b<50 && c<60 )
   
    set(handles.colorquality,'string','Pass ');
    set(handles.colorquality, 'Background', [0.0 0.957 0.239]);
    set(handles.colorquality, 'Foreground', 'white'); 
    
elseif(a<=185 && b<=255 && c<=170 )
   
    set(handles.colorquality,'string','Pass ');
    set(handles.colorquality, 'Background', [0.0 0.957 0.239]);
    set(handles.colorquality, 'Foreground', 'white'); 
    
elseif(a>=235 && b<=160 && b>120 && c<80 && c>20  )
   
    set(handles.colorquality,'string','Pass');
    set(handles.colorquality, 'Background', [0.0 0.957 0.239]);
  set(handles.colorquality, 'Foreground', 'white'); 
    
else  
     set(handles.colorquality,'string','Fail');
     set(handles.colorquality, 'Background', [1.0 0.0 0.0]);
     set(handles.colorquality, 'Foreground', 'white');
     
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%===================Praveen's CODE========================= 

function pushbutton4_Callback(hObject, eventdata, handles)


x = handles.x1;%get the input image
gray_x = rgb2gray(x);   %convert image to grayscale
output = pushbutton3_Callback(hObject, eventdata, handles); %call the result of color detect part

red = x( : , : , 1);%extract red plane
green = x( : , : , 2);%extract green plane

if (output == 1)
    object = red;
    sub_obj = imsubtract(object, gray_x);
    graythresh_level = 0.03;%Thresholding part
    sub_objbw = im2bw (sub_obj,graythresh_level);
       
else    
    object = green;   
    sub_obj = imsubtract(object, gray_x);
    graythresh_level = 0.03;%Thresholding part
    sub_objbw = im2bw (sub_obj,graythresh_level);    
        
end
 
clean_img = bwareaopen(sub_objbw, 1000);%Avoid the small objects
BW_filled=imfill(clean_img,'holes');

area = bwarea(BW_filled);%Calculate the area of the bounded image
Rounded_Area = round(area);%Round the area value

BW1 = edge(BW_filled,'Canny');%This 'Canny' method uses two thresholds to detect strong and weak edges,
                              %including weak edges in the output if they are connected to strong edges


%=====================Plot Images========================

axes(handles.axes7);%This axes use to plot the outputs
imshow(gray_x); pause(0.5);
imshow(object); pause(0.5);
imshow(clean_img); pause(0.2);
imshow(BW_filled); pause(0.2);
imshow(BW1); pause(0.2);

if (object == red)
    imshow(BW1); title('Bounded Image-Size Detected!');
    map = [0 0 0;1 0 0]; % Using red color to map
    colormap(map);
else
    imshow(BW1); title('Bounded Image-Size Detected!');
    map = [0 0 0;0 1 0]; %Using green color to map
    colormap(map);
end

%Static Text Update conditions
if object == red
    if Rounded_Area >= 20000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.024 0.0 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 15000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.22 0.212 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 9500
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Too Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    end 
else   
    if Rounded_Area >= 17000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.024 0.0 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 13000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.22 0.212 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif Rounded_Area >= 9500
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Too Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    end     
end


%===================MAHELA CODE=========================  

if object == red
    if Rounded_Area >= 20000
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    elseif Rounded_Area >= 15000
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    elseif Rounded_Area >= 9500
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    else 
        set(handles.sizequality, 'String', 'Fail');
        set(handles.sizequality, 'Background', [1.0 0.0 0.0]);
        set(handles.sizequality, 'Foreground', 'white');
    end 
    
else   
    if Rounded_Area >= 17000
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    elseif Rounded_Area >= 13000
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    elseif Rounded_Area >= 9500
        set(handles.sizequality, 'String', 'Pass');
        set(handles.sizequality, 'Background', [0.0 0.957 0.239]);
        set(handles.sizequality, 'Foreground', 'white');
        
    else
        set(handles.sizequality, 'String', 'Fail');
        set(handles.sizequality, 'Background',[1.0 0.0 0.0]);
        set(handles.sizequality, 'Foreground', 'white');
        
    end     
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%set(handles.statusquality, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.colordet, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.status_size, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.surfacequality, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.colorquality, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.surfacefail, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.colorfail, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.sizefail, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.TotalFailCount, 'String', '-', 'Background', 'white', 'Foreground', 'black');
set(handles.TotalPassCount, 'String', '-', 'Background', 'white', 'Foreground', 'black');

%set(handles.surfacequality, 'String', '-', 'Background', 'white', 'Foreground', 'black');
%set(handles.colorquality, 'String', '-', 'Background', 'white', 'Foreground', 'black');
%set(handles.sizequality, 'String', '-', 'Background', 'white', 'Foreground', 'black');






% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq();
Login_page


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








% --- Executes on button press in pushbutton2.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes during object creation, after setting all properties.
function Statustext1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Statustext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



% --- Executes during object creation, after setting all properties.
function Statustext3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Statustext3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function colorquality_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorquality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function axes3_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function uipanel2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function colorquality_Callback(hObject, eventdata, handles)
% hObject    handle to colorquality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorquality as text
%        str2double(get(hObject,'String')) returns contents of colorquality as a double



function surfacequality_Callback(hObject, eventdata, handles)
% hObject    handle to surfacequality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of surfacequality as text
%        str2double(get(hObject,'String')) returns contents of surfacequality as a double


% --- Executes during object creation, after setting all properties.
function surfacequality_CreateFcn(hObject, eventdata, handles)
% hObject    handle to surfacequality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sizequality_Callback(hObject, eventdata, handles)
% hObject    handle to colorquality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorquality as text
%        str2double(get(hObject,'String')) returns contents of colorquality as a double


% --- Executes during object creation, after setting all properties.
function sizequality_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorquality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sizefail_Callback(hObject, eventdata, handles)
% hObject    handle to sizefail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sizefail as text
%        str2double(get(hObject,'String')) returns contents of sizefail as a double


% --- Executes during object creation, after setting all properties.
function sizefail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizefail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function surfacefail_Callback(hObject, eventdata, handles)
% hObject    handle to surfacefail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of surfacefail as text
%        str2double(get(hObject,'String')) returns contents of surfacefail as a double


% --- Executes during object creation, after setting all properties.
function surfacefail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to surfacefail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorfail_Callback(hObject, eventdata, handles)
% hObject    handle to colorfail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorfail as text
%        str2double(get(hObject,'String')) returns contents of colorfail as a double


% --- Executes during object creation, after setting all properties.
function colorfail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorfail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TotalFailCount_Callback(hObject, eventdata, handles)
% hObject    handle to TotalFailCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotalFailCount as text
%        str2double(get(hObject,'String')) returns contents of TotalFailCount as a double


% --- Executes during object creation, after setting all properties.
function TotalFailCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalFailCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
