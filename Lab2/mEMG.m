load EMG.mat
fs=1000;
N=5000;
t=1:22500;
y=EMG(t);
figure(1)
subplot(311)
plot(t(1:45),y(1:45));
title('EMG信号时域波形(45点)');
subplot(312)
plot(t,y);
title('EMG信号时域波形');
subplot(313)
freq=fft(y,N)/N;%做离散傅里叶
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %双边  
plot(w,freq_d);
ylim([0,1]);
title('EMG信号频谱');
xlabel('频率/Hz');
ylabel('幅值/V');
%功率谱
figure(2)
subplot(211)
ypsd=freq_d.*conj(freq_d);
plot(w,ypsd);
title('EMG信号功率谱');
xlabel('频率/Hz');
ylabel('W/Hz');
%信号自相关
subplot(212)
[Rx,maxlags]=xcorr(y,'unbiased');  %信号的自相关
    plot(maxlags/fs,Rx/max(Rx));
    xlim([-0.05,0.05]);
    xlabel('时延差/s');
title('EMG信号自相关');
ylabel('R(τ)');
ylim([-0.5,1.2]);
aver=mean(y)
v=var(y)