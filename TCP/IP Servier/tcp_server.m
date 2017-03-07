% A端:发送命令,并接收B端反馈
% A端IP为192.168.123.30, B端IP为192.168.123.10

clear;clc;close all;
dec2int = @(x, bits) mod(x + 2^(bits-1), 2^bits) - 2^(bits-1);
color='rgb'
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 2048;             % Length of signal
t = (0:L-1)*T;        % Time vector

disp_length=L;
% 构造服务器端tcpip对象
tcpipServer = tcpip('0.0.0.0',3333,'NetWorkRole','Server');
set(tcpipServer,'Timeout',10);
N = 2048;
set(tcpipServer,'InputBufferSize',16*N);
set(tcpipServer,'OutputBufferSize',1024);

% 打开连接对象
fopen(tcpipServer);

% 发送指令
instruction = '{"jsonType":"controlInfo","freq":50,"userName":"15055305685","productMac":"00:CA:01:0F:00:01","sampleNum":20000,"fileName":"blue","channelList":"1"}';
% instruction = '{"jsonType":"controlInfo","freq":1000,"userName":"15055305685","productMac":"00:CA:01:0F:00:01","sampleNum":80000,"fileName":"blue","channelList":"012"}';

fwrite(tcpipServer,instruction,'int8');
disp('Instruction sending succeeds.');
numSent = get(tcpipServer,'valuesSent');
disp(strcat('Bytes of instruction is :',num2str(numSent)));


% 绘制接收数据图像
figure;
set(gcf,'position',get(0,'ScreenSize'));
subplot(2,1,1)
hold on
title('received signal from controler');
% ylim([-2000 2000])

subplot(2,1,2)
hold on
title('Single-Sided Amplitude Spectrum of X(t)');

cmd=[];
ad_value=[];
x=zeros(4,2048);
recv_num=zeros(1,4);
h=zeros(1,4);
hf=zeros(1,4);
num=0;
% x=zeros(4,2048);
while(1)
%    等待接收数据
    while(1)
        nBytes = get(tcpipServer,'BytesAvailable');
        if nBytes > 0
            break;
        end
        pause(0.01);
    end
    nBytes
    % 接收数据
    recvRaw = fread(tcpipServer,nBytes,'int8') ;
    cmd = [cmd recvRaw'];
    idx=find(cmd==0);
    while ~isempty(idx)
        json_str=cmd(1:idx(1)-1);
        cmd=cmd(idx(1)+1:end);
        
        if ~isempty(strfind(char(json_str),'channel_info'))
            result=loadjson(char(json_str));
%             result=loadjson('test_json.txt')
            channel_list=result.channelList;
            num=result.channel_info.num;
            data=result.channel_info.data;
            hex=str2hex(data);
            data_length=size(hex,2)/2;
            ad_value=zeros(1,data_length);
            for j=1:data_length
                ad_value(j)=hex(2*j-1)*256+hex(2*j);
                ad_value(j)=dec2int(ad_value(j),16);
            end
            if recv_num(num+1)==0
                x(num+1,1:data_length)=ad_value;   
            else
                x(num+1,1:recv_num(num+1)+data_length)=[x(num+1,1:recv_num(num+1)) ad_value];
            end
            recv_num(num+1)=recv_num(num+1)+data_length;
            
%            /************ run in shift mode when this code is enabled*************/

            if size(x,2)> L
                x(num+1,1:L)=x(num+1,end-L+1:end);
                x(:,L+1:end)=[];
                recv_num(num+1)=L;
            end
%             
%            /************ run in shift mode when this code is enabled*************/        


            subplot(2,1,1)
            
            if num==0
                if h(num+1)~=0
                    delete(h(num+1))
                end
                
                h(num+1)=plot(1:recv_num(num+1),x(num+1,1:recv_num(num+1)),'color','r')    
               
                if recv_num(num+1) >= L
                    subplot(2,1,2)

                    Y = fft(x(num+1,end-L+1:end));
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    f = Fs*(0:(L/2))/L;
                    
                    if hf(num+1)~=0
                        delete(hf(num+1))
                    end
                    hf(num+1)=plot(f(1:200),P1(1:200),'color','r')
%                     hf(num+1)=plot(f,P1,'color','r')
%                     [max_hz,idx]=max(P1(2:end));
%                     leg=legend(['The current preq is:  ', num2str(f(idx+1))]);
%                     pause(0.001);
%                     set(leg,'Fontsize',12)
%                     title('Single-Sided Amplitude Spectrum of X(t)')
%                     set(gca,'Fontsize',12)
%                     xlabel('f (Hz)')
%                     ylabel('|P1(f)|')
                end
                 
            end
            if num==1
                if h(num+1)~=0
                    delete(h(num+1));
                end
                h(num+1)=plot(1:recv_num(num+1),x(num+1,1:recv_num(num+1)),'color','g');  
                
                if recv_num(num+1) >= L
                    subplot(2,1,2)
%                     Y = fft(x(num+1,1:recv_num(num+1)));
                    Y = fft(x(num+1,end-L+1:end));
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    f = Fs*(0:(L/2))/L;

                    if hf(num+1)~=0
                        delete(hf(num+1));
                    end
                    hf(num+1)=plot(f(1:200),P1(1:200),'color','g');
%                     hf(num+1)=plot(f,P1,'color','g')
%                     [max_hz,idx]=max(P1(2:end));
%                     leg=legend(['The current preq is:  ', num2str(f(idx+1))]);
%                     set(leg,'Fontsize',12)
%                     title('Single-Sided Amplitude Spectrum of X(t)')
%                     set(gca,'Fontsize',12)
%                     xlabel('f (Hz)')
%                     ylabel('|P1(f)|')
                end
            end
            if num==2
                if h(num+1)~=0
                    delete(h(num+1));
                end
                h(num+1)=plot(1:recv_num(num+1),x(num+1,1:recv_num(num+1)),'color','b') 
                
               if recv_num(num+1) >= L
                    subplot(2,1,2)
%                     Y = fft(x(num+1,1:recv_num(num+1)));
                    Y = fft(x(num+1,end-L+1:end));
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    
                    f = Fs*(0:(L/2))/L;
                    if hf(num+1)~=0
                        delete(hf(num+1));
                    end
                    hf(num+1)=plot(f(1:200),P1(1:200),'color','b');
%                     hf(num+1)=plot(f,P1,'color','b')
%                     [max_hz,idx]=max(P1(2:end));
%                     leg=legend(['The current preq is:  ', num2str(f(idx+1))]);
%                     set(leg,'Fontsize',12)
%                     title('Single-Sided Amplitude Spectrum of X(t)')
%                     set(gca,'Fontsize',12)
%                     xlabel('f (Hz)')
%                     ylabel('|P1(f)|')
                end
            end
            if num==3
                if h(num+1)~=0
                    delete(h(num+1));
                end
                h(num+1)=plot(1:recv_num(num+1),x(num+1,1:recv_num(num+1)),'color','k'); 
                if recv_num(num+1) >= L
                    subplot(2,1,2)

                    Y = fft(x(num+1,end-L+1:end));
                    P2 = abs(Y/L);
                    P1 = P2(1:L/2+1);
                    P1(2:end-1) = 2*P1(2:end-1);
                    f = Fs*(0:(L/2))/L;
                    
                    if hf(num+1)~=0
                        delete(hf(num+1))
                    end
                    hf(num+1)=plot(f(1:200),P1(1:200),'color','k')
                end
            end

        end     
        idx=find(cmd==0);
    end

       




    
%     
% %     if size(x,2)>disp_length
% %         x=x(end-disp_length+1:end);
% %     end
% %     x=x-mean(x);
%     nums=size(cmd,2);
%     subplot(211)
%     plot(cmd);
%     ylim([0 5000])
%     if nums < L
%         plot(cmd)
% %     else
% %         plot(1000*t,x)
%     end
%     ylim([-2000 2000])
%     title('Time-domain Signal')
%     xlabel('t (milliseconds)')
%     ylabel('X(t)') 
%     set(gca,'Fontsize',12)
%     
%     subplot(212)
%     if nums >= L
%         Y = fft(cmd);
%         P2 = abs(Y/L);
%         P1 = P2(1:L/2+1);
%         P1(2:end-1) = 2*P1(2:end-1);
%         f = Fs*(0:(L/2))/L;
%         plot(f(1:20),P1(1:20))
%         [max_hz,idx]=max(P1(2:end));
%         leg=legend(['The current preq is:  ', num2str(f(idx+1))]);
%         set(leg,'Fontsize',12)
%         title('Single-Sided Amplitude Spectrum of X(t)')
%         set(gca,'Fontsize',12)
%         xlabel('f (Hz)')
%         ylabel('|P1(f)|')
%     end


    
%     fwrite(tcpipServer,'{"jsonType":"controlInfo"}','int8');
%     pause(0.1);
end

% 关闭和删除连接对象
fclose(tcpipServer);
delete(tcpipServer);



% % % % % A端:发送命令,并接收B端反馈
% % % % % A端IP为192.168.123.30, B端IP为192.168.123.10
% % % % 
% % % % clear;clc;close all;
% % % % 
% % % % Fs = 1000;            % Sampling frequency
% % % % T = 1/Fs;             % Sampling period
% % % % L = 2048;             % Length of signal
% % % % t = (0:L-1)*T;        % Time vector
% % % % 
% % % % disp_length=L;
% % % % % 构造服务器端tcpip对象
% % % % tcpipServer = tcpip('0.0.0.0',3333,'NetWorkRole','Server');
% % % % set(tcpipServer,'Timeout',10);
% % % % N = 2048;
% % % % set(tcpipServer,'InputBufferSize',16*N);
% % % % set(tcpipServer,'OutputBufferSize',1024);
% % % % 
% % % % % 打开连接对象
% % % % fopen(tcpipServer);
% % % % 
% % % % % 发送指令
% % % % instruction = '{"jsonType":"controlInfo","freq":1000,"userName":"15055305685","productMac":"00:CA:01:0F:00:01","sampleNum":80000,"fileName":"blue","channelList":"3"}';
% % % % % instruction = '{"jsonType":"dataReport","timeInterval":1,"userName":"15055305685","productMac":"00:CA:01:0F:00:01","freq":0,"sampleNum":1,"channelList":"7"}';
% % % % fwrite(tcpipServer,instruction,'int8');
% % % % disp('Instruction sending succeeds.');
% % % % numSent = get(tcpipServer,'valuesSent');
% % % % disp(strcat('Bytes of instruction is :',num2str(numSent)));
% % % % 
% % % % % 等待接收数据
% % % % while(1)
% % % %     nBytes = get(tcpipServer,'BytesAvailable');
% % % %     if nBytes > 0
% % % %         break;
% % % %     end
% % % % end
% % % % 
% % % % % 接收数据
% % % % nBytes
% % % % recvRaw = fread(tcpipServer,nBytes,'int16');
% % % % x=recvRaw';
% % % % 
% % % % % 绘制接收数据图像
% % % % figure;
% % % % subplot(211)
% % % % plot(x);
% % % % grid on;
% % % % ylim([0 5000])
% % % % title('received signal from B');
% % % % % x=[];
% % % % while(1)
% % % % %    等待接收数据
% % % %     while(1)
% % % %         nBytes = get(tcpipServer,'BytesAvailable');
% % % %         if nBytes > 0
% % % %             break;
% % % %         end
% % % %         pause(0.01);
% % % %     end
% % % %     nBytes
% % % %     % 接收数据
% % % %     recvRaw = fread(tcpipServer,nBytes,'int16') ;
% % % %     x = [x recvRaw'];
% % % %     if size(x,2)>disp_length
% % % %         x=x(end-disp_length+1:end);
% % % %     end
% % % % %     x=x-mean(x);
% % % %     nums=size(x,2);
% % % %     subplot(211)
% % % %     plot(x);
% % % %     ylim([0 5000])
% % % %     if nums < L
% % % %         plot(x)
% % % % %     else
% % % % %         plot(1000*t,x)
% % % %     end
% % % %     ylim([-2000 2000])
% % % %     title('Time-domain Signal')
% % % %     xlabel('t (milliseconds)')
% % % %     ylabel('X(t)') 
% % % %     set(gca,'Fontsize',12)
% % % %     
% % % %     subplot(212)
% % % %     if nums >= L
% % % %         Y = fft(x);
% % % %         P2 = abs(Y/L);
% % % %         P1 = P2(1:L/2+1);
% % % %         P1(2:end-1) = 2*P1(2:end-1);
% % % %         f = Fs*(0:(L/2))/L;
% % % %         plot(f(1:20),P1(1:20))
% % % %         [max_hz,idx]=max(P1(2:end));
% % % %         leg=legend(['The current preq is:  ', num2str(f(idx+1))]);
% % % %         set(leg,'Fontsize',12)
% % % %         title('Single-Sided Amplitude Spectrum of X(t)')
% % % %         set(gca,'Fontsize',12)
% % % %         xlabel('f (Hz)')
% % % %         ylabel('|P1(f)|')
% % % %     end
% % % % 
% % % % 
% % % %     
% % % % %     fwrite(tcpipServer,'{"jsonType":"controlInfo"}','int8');
% % % %     pause(0.1);
% % % % end
% % % % 
% % % % % 关闭和删除连接对象
% % % % fclose(tcpipServer);
% % % % delete(tcpipServer);