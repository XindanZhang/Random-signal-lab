%% 将软件产生的数据读取到matlab环境下
clc;
clear;

%% 读取文件中数据，对于只有数字的txt文件，直接使用load加载

rng('default')  % For reproducibility
%data = randn(size(t));
%u =makedist('Uniform','lower',-2,'upper',2); % Uniform distribution with a = -2 and b = 2
% data = load('D:\suiji2\2.txt');   %加载文件数据,伯努利数据库

%plot(x,pdf1,'r','LineWidth',2); 
%data = rand(u);
%fs = 1000;
%N = 1000;
fs = 100000;% 泊松采样率/Gamma采样率/伯努利采样率
N = 50000;
dt=1/fs;     %时间间隔
t=0:dt:(N-1)*dt;    %时间向量% 采样率
%t = 0:1/fs:1-1/fs;
%t = (1:N)/fs;    
%data = rand(1,1000);%均匀分布（0,1）之间
%data = normrnd(0,1,1,1000);% 高斯分布
%data = random('Poisson',10,1,50000);%泊松分布
%data = gamrnd(30,1,1,50000);%Gamma分布设置阶数a变化，b的值固定为1
% data = binornd(1,0.8,[1,50000]);%伯努利
data = binornd(100,0.9,[1,50000]);%二项分布，实验次数为100；

disp(['输入num=',num2str(data)]);
%N = length(data);
freqPixel = fs/N;
aver0 = mean(data);
v0=var(data);
disp(['输入均值=',num2str(aver0)]);
disp(['输入方差=',num2str(v0)]);
figure(1);
subplot(2,1,1);
plot(t,data);                % 绘制读取的数据波形
title('均匀信号时域波形图');%0-1
xlabel('时间/s');
ylabel('幅值');
h=fft(data,N)*2/N;                 %快速傅里叶变换
h_d=abs(fftshift(h));           %使频域图像中间为零
w=(-N/2:1:N/2-1)*freqPixel;            %将取得时间上的点转化为频率上的点
subplot(2,1,2);
plot(w,h_d);              %画原始图像频域上图

title('输入信号的频域波形');
xlabel('频率/HZ');
ylabel('幅度');
%%
ypsdi=h_d.*conj(h_d);
figure(2)
subplot(211)
plot(w,ypsdi);
title('输入信号功率谱');
xlabel('频率/Hz');
ylabel('幅度/V');
%%
%输入信号的自相关
subplot(212)
[Rx0,maxlags]=xcorr(data,'unbiased');  %信号的自相关
if fs>10000  %调整时间轴单位及标签,便于观测波形
    plot(maxlags/fs*1000,Rx0/max(Rx0));
    xlabel('时延差/ms');
else
    plot(maxlags/fs,Rx0/max(Rx0));
    xlabel('时延差/s');
end
title('输入信号自相关');
xlabel('时间/s');
ylabel('幅值/V');
%%
% figure(3)
% periodogram(data,rectwin(N),N,fs)
% figure(4)
% periodogram(data,rectwin(N),N)

%%
figure(5) %统计直方图=概率密度0
% x = 0:0.1:50;
% y2 = gampdf(x,30,1);
% plot(x,y2,color='red')

histogram(data,50);
grid on;

