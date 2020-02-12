clear all
%% Import the data
[~, ~, raw] = xlsread('D:\home_work\CE253\Hw2\ps2_Q1_data.xls','data','A2:H121');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
ps2Q1data = reshape([raw{:}],size(raw));

%% Clear temporary variables
clearvars raw R;
ps2Q1data_1=ps2Q1data;
%% Assume 50% of delay goes to incident
nnn=nan(length(ps2Q1data),1);
peakind=find(ps2Q1data(:,2)>=6&ps2Q1data(:,2)<10);

peakind=[peakind; find(ps2Q1data(:,2)>=15&ps2Q1data(:,2)<19)];
%select peak hours
ps2Q1data=ps2Q1data(peakind,:);
% select off-peak hours
% ps2Q1data(peakind,3)=nnn(peakind);
% ps2Q1data=ps2Q1data(~isnan(ps2Q1data(:,3)),:);


V=60; %ref spd
DLind=find(ps2Q1data(:,3)<V);
dly=zeros(1,length(ps2Q1data));
dly(DLind)=ps2Q1data(DLind,6)-ps2Q1data(DLind,5)./V;
accind=find(ps2Q1data(:,7)+ps2Q1data(:,8));
accidly=zeros(1,length(ps2Q1data));
accidly(accind)=dly(accind)*0.5;

totdly=sum(dly);
totaccidly=sum(accidly);
temp=sort(dly);
1
mean(dly)
var(dly)
for i=1:length(dly)
    prob(i)=length(find(temp<temp(i)))/length(dly);
    
    
end

plot(temp,prob)
xlabel('delay in veh h')
ylabel('probability')
title('CDF')
clear temp
%% part b
%group data by 2 hours
j=1
for i=1:2:length(ps2Q1data)-1
    temp=ps2Q1data(i:i+1,:);
    W=temp(:,4)./sum(temp(:,4));
    weight1=ones(size(temp));
    weight1(1,3)=weight1(1,3)*W(1);
    weight1(2,3)=weight1(2,3)*W(2);
    data_fused(j,3)=sum(temp(:,3) .*W);
    data_fused(j,[1 2 4:8])=temp(1,[1 2 4:8])+temp(2,[1 2 4:8]);
    j=j+1;
end
clear temp
DLind1=find(data_fused(:,3)<V);
dly1=zeros(1,length(data_fused));
dly1(DLind1)=(data_fused(DLind1,6)-data_fused(DLind1,5)./V);
accind1=find(data_fused(:,7)+data_fused(:,8));
accidly1=zeros(1,length(data_fused));
accidly1(accind1)=dly1(accind1)*0.5;

totdly1=sum(dly1);
totaccidly1=sum(accidly1);
temp1=sort(dly1);
2
mean(dly1)
var(dly1)
for i=1:length(dly1)
    prob1(i)=length(find(temp1<temp1(i)))/length(dly1);
    
    
end
figure (2)
plot(temp1,prob1)
xlabel('delay in veh h')
ylabel('probability')
title('CDF')

%% part 3
nnnn=nan(1,length(ps2Q1data));
temp=zeros(1,length(ps2Q1data));
temp(accind)=nnnn(accind);
Xaccident=find(~isnan(temp));
TT=10./ps2Q1data(Xaccident,3);
avg_spd=mean(ps2Q1data(Xaccident,3))
clear temp
sspd=ps2Q1data(Xaccident,3);
sspd1=ps2Q1data(accind,3);
clear prob
temp=sort(TT);
for i=1:length(TT)
    prob(i)=length(find(temp<temp(i)))/length(TT);
    
    
end
figure (3)
plot(temp./min(temp),prob)
FFTT=min(temp);
TTI=temp./min(temp);
11
mean(temp./min(temp))
xlabel('travel time in h')
ylabel('probability')
title('CDF TTI without accident')

clear temp
clear prob

tti=10./ps2Q1data(accind,3);
temp=sort(tti);
avg_spd_accid=mean(ps2Q1data(accind,3));

for i=1:length(tti)
    prob(i)=length(find(temp<temp(i)))/length(tti);
    
    
end
figure(4)
plot(temp./FFTT,prob)
TTI1=temp./FFTT;
12
mean(temp./FFTT)
xlabel('travel time in  h')
ylabel('probability')
title('CDF TTI with accident')
AT=10/avg_spd;
ATi=10/avg_spd_accid;
prctile(TTI,95)
prctile(TTI1,95)
prctile(TTI,80)
prctile(TTI1,80)
skew1=(prctile(TTI1,90)-median(TTI1))/(median(TTI1)-prctile(TTI1,10));
skew=(prctile(TTI,90)-median(TTI))/(median(TTI)-prctile(TTI,10));
MT=median([TTI; TTI1])
FM=length(find(TTI<1.1*MT))/length(TTI);
OM=length(find(sspd<45))/length(sspd);
FM1=length(find(TTI1<1.1*MT))/length(TTI1);
OM1=length(find(sspd1<45))/length(sspd1);

MI=mean(TTI(TTI>=prctile(TTI,95)))/FFTT;
MI1=mean(TTI1(TTI1>=prctile(TTI1,95)))/FFTT;