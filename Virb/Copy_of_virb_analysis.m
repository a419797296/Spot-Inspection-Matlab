data=load('a.mat');
a=data.a;
a=a';




Fs = 500;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 5000;             % Length of signal
t = (0:L-1)*T;        % Time vector

a = 200*sin(2*pi*t)+1
subplot(221)
plot(t,a)
title('Signal of Acceleration')
xlabel('t (seconds)')
ylabel('a(t)')

subplot(222)
A = fft(a);

P2 = abs(A/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of a(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% calc velocity
g_a=(a-mean(a))/100*10*1000;
g_a=(a)/100*10*1000;
for i=1:L
    v(i)=trapz(g_a(1:i))*T;
end
subplot(223)
plot(t,v);
title('Signal of Velocity')
xlabel('t (second)')
ylabel('|mm/s|')

V = fft(v);

P2 = abs(V/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(224)
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of v(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% calc distance
% for i=1:L
%     s(i)=trapz(v(1:i))*T;
% end
% subplot(224)
% plot(t,s);
% title('displacement of s(t)')
% xlabel('t (second)')
% ylabel('|mm|')