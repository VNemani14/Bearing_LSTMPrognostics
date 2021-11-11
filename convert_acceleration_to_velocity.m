% This code converts the vibration data from the acceleration domain to
% velocuty domain

clear all
shaftfr=[35*ones(1,5), 37.5*ones(1,5), 40*ones(1,5)]; %shaft freq in Hz
sf=25.6e3;          %sampling frequency
samplingt=1.28;     %sampling time

for bindex=1:1   %For each bearing
    load("originaldata/bearing"+ num2str(bindex) +'.mat')
    [npoints,~,m]=size(rawnet); %rawnet is the original vibration data with size (sf*samplingt,#axis, samples)
    
    tt=linspace(0,samplingt,npoints);
    vibrationv_x=zeros(npoints,1);
    vibrationv_y=zeros(npoints,1);
    f = waitbar(0,"Converting for bearing " + num2str(bindex));  
    for mysample=1:m %for each sample
        rawsignal=rawnet(:,:,mysample);
        vibrationa_x=rawsignal(:,1); %horizontal axis time-series
        vibrationa_x=vibrationa_x-mean(vibrationa_x); %mean correction

        vibrationa_y=rawsignal(:,2);
        vibrationa_y=vibrationa_y-mean(vibrationa_y);

        for i=2:npoints  % numerical integration
           vibrationv_x(i)=trapz(tt(1:i),vibrationa_x(1:i)); 
           vibrationv_y(i)=trapz(tt(1:i),vibrationa_y(1:i));
        end
        vibrationv_x=vibrationv_x*9.8*39.37;     % convert into ips
        vibrationv_y=vibrationv_y*9.8*39.37;     % convert into ips
        vbearing(mysample,1,:)=vibrationv_x;
        vbearing(mysample,2,:)=vibrationv_y;
        waitbar(mysample/m);
    end
    
    save("processeddata/VBearing_"+ num2str(bindex) +'.mat','vbearing')
end


