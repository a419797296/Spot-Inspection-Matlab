function varargout = untitled(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
 %% warning('off');
%% ���ǵð�clear��clc����
%�޸�ͼ��
% javaFrame = get(hObject, 'JavaFrame');
% javaFrame.setFigureIcon(javax.swing.ImageIcon('ͷ��.jpg'));
% hAxes = axes('visible', 'off', 'units', 'normalized', 'position', [0 0 1 1]);  %ǰ��һ��1��ʾ���ҳ���������һ����ʾ���³�����
% axis off;
%% ��ʾͼƬ
% cData = imread('����ͼƬ.jpg');%%%%%%%%%%%%%%%ͼƬ�Լ����أ����浽��ǰĿ¼����
% image(cData);


guidata(hObject, handles);   %��������

% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function listbox3_Callback(hObject, eventdata, handles)

function listbox3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function COM_menu_Callback(hObject, eventdata, handles)

function COM_menu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in BAUD_menu.
function BAUD_menu_Callback(hObject, eventdata, handles)

function BAUD_menu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CHECK_menu.
function CHECK_menu_Callback(hObject, eventdata, handles)

function CHECK_menu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in STOP_menu.
function STOP_menu_Callback(hObject, eventdata, handles)

function STOP_menu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end 



% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)

function COM_menu_KeyPressFcn(hObject, eventdata, handles)

function figure1_CreateFcn(hObject, eventdata, handles)

function pushbutton2_Callback(hObject, eventdata, handles)
global s;
COM_value=get(handles.COM_menu,'value');  %�õ���ǰCOM_menu��ֵ
CHECK_value=get(handles.CHECK_menu,'value'); %�õ���ǰCHECK_menu��ֵ
BAUD_value=get(handles.BAUD_menu,'value'); %�õ���ǰBAUD_menu��ֵ
STOP_value=get(handles.STOP_menu,'value'); %�õ���ǰSTOP_menu��ֵ
DATA_value=get(handles.DATA_menu,'value'); %�õ���ǰDATA_menu��ֵ

getcom=instrhwinfo ('serial');
validcom=getcom.SerialPorts;   %�����Ч�Ĵ��ں�

%��ȡ����menu������ֵ
currentcom={'COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9','COM10','COM11','COM12','COM13','COM14','COM15'};
currentcheck={'NONE','ODD','EVEN'};
currentbaud=[300 600 1200 2400 4800 9600 19200 38400 43000 56000 57600 115200];
currentstop=[1 2];
currentdata=[6 7 8];
judge0=strcmpi(currentcom{COM_value},validcom); %�����Ч���ں����õĴ���һ��Ϊ1������Ϊ0
if sum(judge0)
    s = serial(currentcom{COM_value},'BaudRate',currentbaud(1,BAUD_value),'DataBits',currentdata(1,DATA_value),... %������ЧCOM��
        'Parity',currentcheck{CHECK_value},'StopBits',currentstop(1,STOP_value),...
        'InputBufferSize',1000,...  %���ջ���ֵ���ֵΪ1000
        'TimeOut',1,...
          'TimerPeriod', 0.1,...   %ÿ2�����һ�ν��յĻص�����
          'timerfcn', {@mycallback,handles});
      %�������������������������������������Ч
%         'BytesAvailableFcnMode','terminator',...   %һ�����յ���ֹ���������ص���������λ��ÿ�η���һ�����ݣ��ͻ������ݵĽ�β��һ����ֹ��
%         'BytesAvailableFcn',{@mycallback,handles});
      
else
     errordlg('��ЧCOM��','��ʾ','replace');   %��ʾ����  ����replace��ֹ�����������  
end

string=get(handles.pushbutton2,'string');%�õ���ǰ����������

if(strcmpi(string,'�رմ���')==1)
    set(handles.pushbutton2,'string','�򿪴���');  %������������Ϊ���򿪴��ڡ�
    set(handles.stat,'backgroundcolor',[0.95 0.95 0.95]);      %�ص�

    %�رմ��ں������޸�menu
    set(handles.COM_menu,'Enable','on');
    set(handles.BAUD_menu,'Enable','on');
    set(handles.DATA_menu,'Enable','on');
    set(handles.CHECK_menu,'Enable','on');
    set(handles.STOP_menu,'Enable','on');    
    
    % ���Ҵ��ڶ���
    scoms = instrfind;
    % ����ֹͣ���ر�ɾ�����ڶ���
    stopasync(scoms);
    fclose(scoms);
    delete(scoms);
else
    if sum(judge0)
        set(handles.pushbutton2,'string','�رմ���');  %������������Ϊ���رմ��ڡ�
        set(handles.stat,'backgroundcolor','g');      %����
        
        %�򿪴��ں��ֹ�޸�menu
        set(handles.COM_menu,'Enable','off');
        set(handles.BAUD_menu,'Enable','off');
        set(handles.DATA_menu,'Enable','off');
        set(handles.CHECK_menu,'Enable','off');
        set(handles.STOP_menu,'Enable','off');
        
        fopen(s);  %�򿪴���
    end
end
%% �ص��������������������
function mycallback(s,BytsAvailable,handles)
hebing='';
a=1
hex_receive=get(handles.radiobutton1,'value');  %Ϊ1��ʾʮ��������ʾ�������ַ���ʾ
if hex_receive
    n_bytes = get(s,'BytesAvailable')     %% ����������
    if n_bytes
        receive_data= fread(s, n_bytes, 'uchar')'    %% �������ݲ�����receive_data�� ֱ��Ϊʮ������ֵ��ʽ  ������һ����ʹ���������
        for i=1:n_bytes
            if receive_data(i)<16
                string_data{i}=sprintf('0%X',receive_data(i));  %��ÿ�����ֶ����һ��С�ַ���
            else
                string_data{i}=sprintf('%2X',receive_data(i));  %��ÿ�����ֶ����һ��С�ַ���
            end
        end
        for i=1:n_bytes
            hebing=strcat(hebing,32,32,string_data{i});  %��ÿ��С�ַ���֮��������ո����һ������ַ���
        end 
%         %%
%         %�������ݿ�
% %��ȡ���ݿ�����                   
%                         waitsmart=database('willtech','root','willtech','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/willtech'); %����rollmeter���ݿ�
%     %                     waitsmart=database('rollmeter','root','willtech','com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/rollmeter'); %����rollmeter���ݿ�
%     %                     ping(waitsmart);
%                         if isempty(waitsmart.URL)
%                             pause(3);
%                             msgbox('���볬ʱ����������������߱�������ǽ���á������룺0x0001��')
%                         else
%                               %�����ݿ��в����뵱ǰ����һ���ļ�¼
%                             curs=exec(waitsmart,['SELECT userid, username, tel, email,ext_num,job_num,position FROM user_info WHERE userid=''',hebing,'''']);
%                             curs=fetch(curs);
%                             db_rollnames=curs.data;
%                             %����ҵ�������������ݿ��ж�ȡ�ù�����Ϣ
%                             if strcmp(db_rollnames{1},hebing)
%                                 
%                                  set(handles.username,'string',db_rollnames{2})
%                                  set(handles.tel,'string',db_rollnames{3})
%                                  set(handles.email,'string',db_rollnames{4})
%                                  set(handles.ext_num,'string',db_rollnames{5})
%                                  set(handles.job_num,'string',db_rollnames{6})
%                                  set(handles.position,'string',db_rollnames{7})
%                             else
%                                 %�����û���Ϣ
%                                 fastinsert(waitsmart,'user_info',{'userid'},{hebing});
% %                                 list={'username','password','cellphone','email'};
% %                                 fastinsert(waitsmart,'user_info',list,info);
% %                                 curs=exec(waitsmart,['UPDATE user_info SET userid=UUID(),villageid=UUID() WHERE cellphone=''',info{3},'''']);
% %                                 fetch(curs);
% %                                 curs=exec(waitsmart,['UPDATE user_info SET userid=UUID(),villageid=UUID() WHERE cellphone=''',info{3},'''']);
% %                                 curs=fetch(curs);                                
% %                                 msgbox('��ϲ���Ѿ�ע��ɹ�����ص����������е��롣')
%         %                         fastinsert(waitsmart,'rollnums',list,info);
%                             end
%                         end
%                         close(curs);  
%                         close(waitsmart);   
        
    end
else
    n_bytes = get(s,'BytesAvailable')    %% ����������
    if n_bytes
        hebing=fscanf(s);    
    end
end
original=get(handles.edit7,'string');   %��������Ϊ�˵õ�ԭ������ʾ�ģ�����ԭ�������ݲ��ᱻ���ǣ��ܹ���ԭ���Ļ���֮�ϼ�����������
hebing=strcat(original,hebing);
set(handles.edit7,'string',hebing); 
%% ���Ͱ���������    
function button_send_Callback(hObject, eventdata, handles)
global s;
send_data=get(handles.edit4,'string');  %�õ�������������
hex_send=get(handles.radiobutton2,'value');

if hex_send  %��Ϊʮ�����Ʒ��ͣ���ȡҪ���͵�����
    n = find(send_data == ' ');   %���ҿո�
    n =[0 n length(send_data)+1]; %�ո������ֵ
    %% ÿ�������ڿո�֮����ַ���Ϊ��ֵ��ʮ��������ʽ������ת��Ϊ��ֵ
    for i = 1 : length(n)-1 
        temp = send_data(n(i)+1 : n(i+1)-1);  %���ÿ�����ݵĳ��ȣ�Ϊ����ת��Ϊʮ������׼��
        if ~rem(length(temp), 2)
            b{i} = reshape(temp, 2, [])'; %��ÿ��ʮ�������ַ���ת��Ϊ��Ԫ����
        else
            break;
        end
    end
    send_data= hex2dec(b)';     %��ʮ�������ַ���ת��Ϊʮ���������ȴ�д�봮��
    fwrite(s,send_data,'uint8', 'async');
else   %�����ASCII
    fprintf(s,send_data);
end

function DATA_menu_Callback(hObject, eventdata, handles)

function DATA_menu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)

function slider2_Callback(hObject, eventdata, handles)

function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton4_Callback(hObject, eventdata, handles)
set(handles.edit4,'string','');    %��շ�����


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
set(handles.edit7,'string','');   %��ս�����


function edit7_Callback(hObject, eventdata, handles)
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radiobutton1_Callback(hObject, eventdata, handles)

function radiobutton2_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function untitled_3_Callback(hObject, eventdata, handles)

 %% ����һ�����صĴ��ڣ�����������λ�õ���Ļ�м�
hFigure = figure('menubar', 'none', 'NumberTitle', 'off', 'position',...
    [0 0 550 550], 'name', 'About Software', 'Visible', 'off');  %ͼƬ�Ĵ�С��550*550
movegui(hFigure, 'center');
%% ���������ᣬ������ʾ����ͼƬ���ı�
hAxes = axes('visible', 'off', 'units', 'normalized', 'position', [0 0 1 1]);  %ǰ��һ��1��ʾ���ҳ���������һ����ʾ���³�����
axis off;
%% ��ʾͼƬ
cData = imread('����ͼƬ.jpg');%%%%%%%%%%%%%%%ͼƬ�Լ����أ����浽��ǰĿ¼����
image(cData);
%% Ҫ��ʾ���ı�����
strCell = {'��Ҫ����ѿһ��            ', '���������ļ���               ',...
    'Ѱ�������Լ���                  ','���������!!!!                     ','by god of death'};
%% ������ʾ�ı�
for i = 1 : numel(strCell)  %���ÿ��ʫ��
    strTemp = strCell{i};   %��ȡ��i��ʫ��
 %   str = [strTemp; 10*ones(1, length(strTemp))]; %ʫ���ÿ���ֺ����һ�����з�
 %   str = str(:)';  %��ȡ����˻��з���ʫ���ַ���
    text('string', strTemp, 'position', [500 i*50], 'Horizontal', 'right',... %position��[0 0]���ڵ�����Ļ�����Ͻ�
        'FontName', '���Ŀ���', 'FontSize', 18, 'FontWeight', 'bold');
end
%% �޸Ĵ������Ͻǵ�ͼ��
newIcon=javax.swing.ImageIcon('ͷ��.jpg');
figFrame = get(hFigure,'JavaFrame'); %ȡ��Figure��JavaFrame��
figFrame.setFigureIcon(newIcon); %�޸�ͼ��
%% ��ʾ����
set(hFigure, 'Visible', 'on');

%����
load gong
sound(y,Fs)
% --------------------------------------------------------------------
function activex1_Change(hObject, eventdata, handles)
% hObject    handle to activex1 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)



function username_Callback(hObject, eventdata, handles)
% hObject    handle to username (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of username as text
%        str2double(get(hObject,'String')) returns contents of username as a double


% --- Executes during object creation, after setting all properties.
function username_CreateFcn(hObject, eventdata, handles)
% hObject    handle to username (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tel_Callback(hObject, eventdata, handles)
% hObject    handle to tel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tel as text
%        str2double(get(hObject,'String')) returns contents of tel as a double


% --- Executes during object creation, after setting all properties.
function tel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function email_Callback(hObject, eventdata, handles)
% hObject    handle to email (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of email as text
%        str2double(get(hObject,'String')) returns contents of email as a double


% --- Executes during object creation, after setting all properties.
function email_CreateFcn(hObject, eventdata, handles)
% hObject    handle to email (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ext_num_Callback(hObject, eventdata, handles)
% hObject    handle to ext_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ext_num as text
%        str2double(get(hObject,'String')) returns contents of ext_num as a double


% --- Executes during object creation, after setting all properties.
function ext_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ext_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function job_num_Callback(hObject, eventdata, handles)
% hObject    handle to job_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of job_num as text
%        str2double(get(hObject,'String')) returns contents of job_num as a double


% --- Executes during object creation, after setting all properties.
function job_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to job_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function position_Callback(hObject, eventdata, handles)
% hObject    handle to position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of position as text
%        str2double(get(hObject,'String')) returns contents of position as a double


% --- Executes during object creation, after setting all properties.
function position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stat.
function stat_Callback(hObject, eventdata, handles)
% hObject    handle to stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
