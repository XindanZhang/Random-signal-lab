clc
clear
close all
%输入信号
R=5100;%滤波器R值
C=1983e-12;%滤波器C值
f0=1/(2*pi*R*C);%滤波器截止频率计算
ct=R*C;%时间常数  
hs=tf(1,[ct 1]);%低通滤波器设计
figure(1)
bode(hs);%滤波器频幅特性
fc=15700;%理论截止频率
%经计算，截止频率f0为15700Hz          
%通带截止时下降3dB，对应频率15700，阻带开始时下降20dB，对应频率156400
fs=5000000; % fs 采样率
A=10;       % A 幅度值
N=500;   % N 采样个数
F0=80000;        
F1=10000; %重复频率等于10KHz的半占空比的方波的频率      所有F小于fs/2（奈奎斯特）
dt=1/fs;    %时间间隔
t=0:dt:(N-1)*dt;    %时间向量
freqPixel=fs/N;     %频率分辨率，即点与点之间频率单位
y0=A*sin(2*pi*F0*t);	%单音正弦波
y1=A*square(2*pi*F1*t,50);%方波
%单音正弦波信号
figure(2)
subplot(211)
plot(t,y0);                       
title('80kHz正弦波输入信号时域图');                    
xlabel('t/s');
ylabel('幅值/V');%输入时域图

figure(3)
subplot(211)
freq0=fft(y0,N)*2/N;%做离散傅里叶变换                     
freq_d0=abs(fftshift(freq0));
w=(-N/2:1:N/2-1)*fs/N; %双边  
plot(w,freq_d0);
title('80kHz正弦波输入信号频谱');                         
xlabel('频率/Hz');
ylabel('幅值/V');%输入频谱图

figure(4)
subplot(211)
ypsd=freq_d0.*conj(freq_d0);
plot(w,ypsd);
title('80kHz正弦波输入信号功率谱');
xlabel('频率/Hz');
ylabel('W/Hz');%输入功率谱

figure(5)
subplot(211)
[Rx,maxlags]=xcorr(y0,'unbiased');              
plot(maxlags/fs*1000,Rx/max(Rx));
title('80kHz正弦波输入信号自相关');
xlabel('t/ms');
ylabel('R(t)');%输入自相关


[yy0,tr]=lsim(hs,y0,t);%信号通过滤波器                
figure(2)
subplot(212)
plot(tr,yy0);
title('80kHz正弦波输出信号时域图');                           
xlabel('t/s');
ylabel('幅值/V');%输出信号时域


figure(3)
subplot(212)
freq=fft(yy0,N)*2/N;%做离散傅里叶
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %双边  
plot(w,freq_d);
title('80kHz正弦波输出信号频谱');                             
xlabel('频率/Hz');
ylabel('幅值/V');%输出频谱图

figure(4)
subplot(212)
ypsd=freq_d.*conj(freq_d);
plot(w,ypsd);
title('80kHz正弦波输出信号功率谱');
xlabel('频率/Hz');
ylabel('W/Hz');%输出功率谱

figure(5)
subplot(212)
[Rx1,maxlags1]=xcorr(yy0,'unbiased'); 
plot(maxlags1/fs*1000,Rx1/max(Rx1));
title('80kHz正弦波输出信号自相关');
xlabel('t/ms');
ylabel('R(t)');%输出自相关