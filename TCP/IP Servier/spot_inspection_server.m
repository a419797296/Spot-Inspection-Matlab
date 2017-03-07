function varargout = spot_inspection_server(varargin)
% SPOT_INSPECTION_SERVER MATLAB code for spot_inspection_server.fig
%      SPOT_INSPECTION_SERVER, by itself, creates a new SPOT_INSPECTION_SERVER or raises the existing
%      singleton*.
%
%      H = SPOT_INSPECTION_SERVER returns the handle to a new SPOT_INSPECTION_SERVER or the handle to
%      the existing singleton*.
%
%      SPOT_INSPECTION_SERVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPOT_INSPECTION_SERVER.M with the given input arguments.
%
%      SPOT_INSPECTION_SERVER('Property','Value',...) creates a new SPOT_INSPECTION_SERVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spot_inspection_server_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spot_inspection_server_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spot_inspection_server

% Last Modified by GUIDE v2.5 03-Aug-2016 11:36:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spot_inspection_server_OpeningFcn, ...
                   'gui_OutputFcn',  @spot_inspection_server_OutputFcn, ...
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


% --- Executes just before spot_inspection_server is made visible.
function spot_inspection_server_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spot_inspection_server (see VARARGIN)

% Choose default command line output for spot_inspection_server
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spot_inspection_server wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spot_inspection_server_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
