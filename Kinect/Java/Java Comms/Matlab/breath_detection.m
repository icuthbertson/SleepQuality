%Matlab code for the project%
clc
clear all
close all
%Read wave file.
strpath = strcat(pwd,'\data\snoring.wav');
[wave,Fs,nbts]=wavread(strpath);
%Downsampling Factor. Depends on Sampling Frequency. For sampling
%frequency > 10kHz Downsampling factor=100, for sampling frequency <10kHz
%and > 1000Hz , Downsampling factor=10.
dnsample=1;
if Fs>10000
    dnsample=100;
else((Fs>1000) & (Fs<10000))
    dnsample=10;
end

%wave1 contains downsampled data.
wave1=downsample(wave,dnsample);

max_signal=max(abs(wave1));
factor=1/max_signal;
wave2=wave1.*factor;

wave=wave2;
%Frequency is also reduced according to Downsampling.
Fs=Fs/dnsample;
%Calculates time of recording.
t=length(wave)/Fs;
x=wave;
%Time axis reconstruction
time1 = (0:length(wave)-1)/(Fs);
%Multiply the two together to get something interesting
y = x ;
%Filter wave data using third order butterworth low pass filter.
[a,b]=butter(3,1/(Fs/2.15),'low');
yabs=abs(y);
%calculate envelope of the recorded voice signal
env=filter(a,b,yabs);
%Calculate peaks in the envelope which basically indicate the instances of
%Inhale and exhale of breath.
[b1,a1]= findpeaks(env,'MINPEAKDISTANCE',60);
%[a,b]=peakfinder(env);
%calculate the largest peak and then normalize the entire envelope
%accordingly.
c=0;
c=b1(1);
for i=1:size(b1,1)
    if c<b1(i)
        c=b1(i);
    end
end

%Using the largest peak value to normalize the entire signal with respect
%to the largest peak value.
env1=env/c;

%Find inhales and exchales according to the normalized envelope
[b,a]=findpeaks(env1,'MINPEAKDISTANCE',60);
%[a,b]=peakfinder(env1);
%Set ranges for classifying breath.
mildbreathrange=0.3;
softbreathrange=0.7;
%hardbreathrange=0.6;
mbc=0; %mild breath counter
sbc=0; %soft breath counter
hbc=0; %hard breath counter
softbreath=[];
mildbreath=[];
hardbreath=[];
%Classification of breath according to amplitude of exhale/inhale
for i=1:(size(b,1))
    if b(i)<=mildbreathrange
        mbc=mbc+1;
        mildbreath(mbc,1)=b(i);%save mild breath amplitude
        mildbreath(mbc,2)=a(i);%save mild breath time instance 
    end
    if b(i)<=softbreathrange && b(i)>mildbreathrange
        sbc=sbc +1;
        softbreath(sbc,1)=b(i); %save softbreath amplitude
        softbreath(sbc,2)=a(i);%save softbreath time instance
    end
    if b(i)>softbreathrange
        hbc=hbc+1;
        hardbreath(hbc,1)=b(i);%save hardbreath amplitude
        hardbreath(hbc,2)=a(i);%save hardbreath time instance
    end
end
leg_ctr=0;
%Plotting the signal and the classified breath.
%set(axes_handle,'YLim',[0,3])
xlim=ceil(length(time1)/Fs);
subplot(3,1,1);
plot(time1,wave);
axis([0,xlim,-2,2]);
%hold on;
title('Raw Signal');
xlabel('time in seconds');
ylabel('Normalized Intensity');
subplot(3,1,2);
plot(time1,env1);
axis([0,xlim,-2,2]);
hold on;
if(sbc>0)
    leg_ctr=leg_ctr+1;
    leg(leg_ctr)=plot(softbreath(:,2)/Fs,env1(softbreath(:,2)),'bx','MarkerSize', 8 ,'linewidth',2);
    leg_str(leg_ctr,:)='softbreath';
    %legend(sb,'softbreath','Location','SouthEastOutside')
    hold on ;
end
if (mbc>0)
    leg_ctr=leg_ctr+1;
    leg(leg_ctr)=plot(mildbreath(:,2)/Fs,env1(mildbreath(:,2)),'rx','MarkerSize', 8,'linewidth',2);
    leg_str(leg_ctr,:)='mildbreath';
    %legend(mb,'mildbreath','Location','SouthEastOutside')
    hold on;
end
if(hbc>0)
    leg_ctr=leg_ctr+1;
    leg(leg_ctr)=plot(hardbreath(:,2)/Fs,env1(hardbreath(:,2)),'cx','MarkerSize',8,'linewidth',2);
    leg_str(leg_ctr,:)='hardbreath';
    %legend(hb,'hardbreath','Location','SouthEastOutside')
end
legend(leg,leg_str,'Location','NorthEast')
title('Normalized envelopes with peaks');
xlabel('time in seconds');
ylabel('Normalized Intensity');
subplot(3,1,3);
plot(time1,env);
axis([0,xlim,-2,2]);
%hold on;
%plot(a/Fs,env(a),'rx','MarkerSize',16,'line width',4);
title('Envelope of abs values of Raw signal');
xlabel('time in seconds');
ylabel('Normalized Intensity');
totalbreaths=length(b)
ctr=0;
bpm=[];
for i=1:round((length(time1)/Fs)/60)
    j=1;
    while(((a(j)/Fs)/60)<i)
        ctr=ctr+1;
        j=j+1;
        if(j>length(a))
            break;
        end
    end
    bpm(i)=ctr;
    ctr=0;
end
i=length(bpm);
while i>1
    bpm(i)=bpm(i)-bpm(i-1);
    i=i-1;
end
if(length(bpm)>0)
    figure();
    lab=num2str(bpm);
    bar(bpm);
	('Bar graph indicating breaths per minute');
    x=[1:length(bpm)]';
    %set(gca,'XTickLabel',lab);
    for i1=1:numel(bpm)
        text(x(i1),bpm(i1),num2str(bpm(i1)),'HorizontalAlignment','center','VerticalAlignment','bottom')
    end
end
figure();
x=[1:3]';
y=[length(hardbreath),length(softbreath),length(mildbreath)];
h=bar(y);
title('Bar graph of classified breaths');
axis('auto');
for i1=1:numel(y)
    text(x(i1),y(i1),num2str(y(i1)),'HorizontalAlignment','center','VerticalAlignment','bottom') 
end
lab={'Hard';'Soft';'Mild'};
set(gca,'XTickLabel',lab);

%Snoring Classification
strpath = strcat('data\snoring',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s';

if hbc > 50
    display('Snoring')
    fprintf(fileID,formatSpec,'Snoring');
else
    display('No Snoring')
    fprintf(fileID,formatSpec,'No Snoring');
end

fclose(fileID);
