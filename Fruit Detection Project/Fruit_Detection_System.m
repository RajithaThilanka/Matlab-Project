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
imshow('photo2.jpg');


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

set(handles.status_size, 'String', '-');
set(handles.status_size, 'Background', 'white');
set(handles.status_size, 'Foreground', 'black');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%imshow('photo2.jpg');


% --- Executes on button press in pushbutton3 color detect part.....


%...Praveen...
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = handles.x1;

gray_x = rgb2gray(x);%convert image to grayscale
 
red = x( : , : , 1);%extract red & green plane
green = x( : , : , 2);
 
object =red;%object is result of the color detect part

 if object == red;     
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
[BW_label,Labels]=bwlabel(BW_filled);   %label the objects

s = regionprops(BW_label, 'BoundingBox');

axes(handles.axes6);

imshow(gray_x);
pause(0.5);
imshow(object);
pause(0.5);
 if object == red;     
     imshow(sub_obj);
     pause(0.5);
     imshow(sub_objbw);
     pause(0.5);     
 else     
     imshow(sub_obj);
     pause(0.5);
     imshow(sub_objbw);
     pause(0.5);    
 end
imshow(clean_img);
pause(0.2);

imshow(x); title('Bounded image - Size Detected!'); 
rectangle('Position', s.BoundingBox, 'EdgeColor','b','LineWidth',1);

width = s.BoundingBox(3);%width of the fruit
height = s.BoundingBox(4);%height of the fruit
area = width * height;%Area of the fruit


if object == red
    if area >= 28000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.024 0.0 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif area >= 20000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.22 0.212 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    end 
else   
    if area >= 20000
        set(handles.status_size, 'String', 'Large');
        set(handles.status_size, 'Background', [0.024 0.0 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    elseif area >= 15000
        set(handles.status_size, 'String', 'Medium');
        set(handles.status_size, 'Background', [0.22 0.212 1.0]);
        set(handles.status_size, 'Foreground', 'white');
    else
        set(handles.status_size, 'String', 'Small');
        set(handles.status_size, 'Background', [0.275 0.424 1.0]);
        set(handles.status_size, 'Foreground', 'white');
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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
