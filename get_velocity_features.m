% This code extracts features from the velocity vibration - both in time
% and frequency domain

clear all
shaftfr=[35*ones(1,5), 37.5*ones(1,5), 40*ones(1,5)]; %shaft freq in Hz
sf=25.6e3;          %sampling frequency
samplingt=1.28;     %sampling time
npoints=sf*samplingt; %number of vibration points in each sample

%bearing geometry
d=7.92;      % ball diameter in mm
D=34.55;     % mean bearing diameter
nballs=8;    % number of balls

for bindex=1:15
    load("processeddata/VBearing_"+ num2str(bindex) +'.mat') %load velocity vibration
    [nsamples,~,~]=size(vbearing); 
    
    BPFO=nballs*shaftfr(bindex)/2*(1-d/D);  % outer race characteristic freq
    BPFI=nballs*shaftfr(bindex)/2*(1+d/D);  % inner race characteristic freq
    FTF=shaftfr(bindex)/2*(1-d/D);          % cage fault
    BSF=D/2/d*(1-d*d/D/D)*shaftfr(bindex);  % ball spin
    
    for mysample=1:nsamples
        raw=vbearing(mysample,1,:);
        raw=reshape(raw,[npoints,1]);
        vibrationx=raw; %horizontal axis time-series
        % time domain features
        FFx(mysample,1)=max(abs(vibrationx)); % max amplitude
        FFx(mysample,2)=rms(vibrationx);      % rms value
        FFx(mysample,3)=kurtosis(vibrationx); % kurtosis

        % FFT
        vibdata=vibrationx;
        df=sf/npoints;
        Y=fft(abs(vibdata));
        P2=abs(Y/npoints);
        P1=P2(1:npoints/2+1);       % double sided spectrum
        P1(2:end-1)=2*P1(2:end-1);  % single sided spectrum
        
        % BPFO 1x, 2x, 3x
        % si=start index, ei=end index
        si=floor(0.95*BPFO/df);ei=floor(1.05*BPFO/df);
        FFx(mysample,4)=max(P1(si:ei));              % max value
        FFx(mysample,5)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);   % rms
        
        si=floor(2*0.95*BPFO/df);ei=floor(2*1.05*BPFO/df);
        FFx(mysample,6)=max(P1(si:ei));
        FFx(mysample,7)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(3*0.95*BPFO/df);ei=floor(3*1.05*BPFO/df);
        FFx(mysample,8)=max(P1(si:ei));
        FFx(mysample,9)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % Inner race fault
        si=floor(0.95*BPFI/df);ei=floor(1.05*BPFI/df);
        FFx(mysample,10)=max(P1(si:ei));
        FFx(mysample,11)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(2*0.95*BPFI/df);ei=floor(2*1.05*BPFI/df);
        FFx(mysample,12)=max(P1(si:ei));   
        FFx(mysample,13)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
       
        si=floor(3*0.95*BPFI/df);ei=floor(3*1.05*BPFI/df);
        FFx(mysample,14)=max(P1(si:ei));
        FFx(mysample,15)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % Ball Spin Freq
        si=floor(0.95*BSF/df);ei=floor(1.05*BSF/df);
        FFx(mysample,16)=max(P1(si:ei));
        FFx(mysample,17)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(2*0.95*BSF/df);ei=floor(2*1.05*BSF/df);
        FFx(mysample,18)=max(P1(si:ei));
        FFx(mysample,19)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(3*0.95*BSF/df);ei=floor(3*1.05*BSF/df);
        FFx(mysample,20)=max(P1(si:ei));
        FFx(mysample,21)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % RMS within FTF 0.2x-0.8x
        si=floor(0.2*shaftfr(bindex)/df);ei=floor(0.8*shaftfr(bindex)/df);
        FFx(mysample,22)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS within 0.8x-1.2x
        si=floor(0.8*shaftfr(bindex)/df);ei=floor(1.2*shaftfr(bindex)/df);
        FFx(mysample,23)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS within 1.2x-3.2x
        si=floor(1.2*shaftfr(bindex)/df);ei=floor(3.2*shaftfr(bindex)/df);
        FFx(mysample,24)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS from 0.2x - end
        si=floor(0.2*shaftfr(bindex)/df);
        FFx(mysample,25)=sqrt(sum(P1(si:end).*P1(si:end))/2);
        % RMS within 1.2x - end
        si=floor(1.2*shaftfr(bindex)/df);
        FFx(mysample,26)=sqrt(sum(P1(si:end).*P1(si:end))/2);
        % RMS within 2.75x (BFF) - end
        si=floor(2.75*shaftfr(bindex)/df);
        FFx(mysample,27)=sqrt(sum(P1(si:end).*P1(si:end))/2);
        
        % Repeat the same as above for the y-direction
        raw=vbearing(mysample,2,:);
        raw=reshape(raw,[npoints,1]);
        tsize=size(raw);
        vibrationx=raw; %horizontal axis time-series
        % time domain features
        FFy(mysample,1)=max(abs(vibrationx)); % max amplitude
        FFy(mysample,2)=rms(vibrationx);      % rms value
        FFy(mysample,3)=kurtosis(vibrationx); % kurtosis

        % FFT
        vibdata=vibrationx;
        df=sf/npoints;
        Y=fft(abs(vibdata));
        P2=abs(Y/npoints);
        P1=P2(1:npoints/2+1);       % double sided spectrum
        P1(2:end-1)=2*P1(2:end-1);  % single sided spectrum
        
        % BPFO 1x, 2x, 3x
        % si=start index, ei=end index
        si=floor(0.95*BPFO/df);ei=floor(1.05*BPFO/df);
        FFy(mysample,4)=max(P1(si:ei));              % max value
        FFy(mysample,5)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);   % rms
        
        si=floor(2*0.95*BPFO/df);ei=floor(2*1.05*BPFO/df);
        FFy(mysample,6)=max(P1(si:ei));
        FFy(mysample,7)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(3*0.95*BPFO/df);ei=floor(3*1.05*BPFO/df);
        FFy(mysample,8)=max(P1(si:ei));
        FFy(mysample,9)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % Inner race fault
        si=floor(0.95*BPFI/df);ei=floor(1.05*BPFI/df);
        FFy(mysample,10)=max(P1(si:ei));
        FFy(mysample,11)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(2*0.95*BPFI/df);ei=floor(2*1.05*BPFI/df);
        FFy(mysample,12)=max(P1(si:ei));   
        FFy(mysample,13)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
       
        si=floor(3*0.95*BPFI/df);ei=floor(3*1.05*BPFI/df);
        FFy(mysample,14)=max(P1(si:ei));
        FFy(mysample,15)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % Ball Spin Freq
        si=floor(0.95*BSF/df);ei=floor(1.05*BSF/df);
        FFy(mysample,16)=max(P1(si:ei));
        FFy(mysample,17)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(2*0.95*BSF/df);ei=floor(2*1.05*BSF/df);
        FFy(mysample,18)=max(P1(si:ei));
        FFy(mysample,19)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        si=floor(3*0.95*BSF/df);ei=floor(3*1.05*BSF/df);
        FFy(mysample,20)=max(P1(si:ei));
        FFy(mysample,21)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        
        % RMS within FTF 0.2x-0.8x
        si=floor(0.2*shaftfr(bindex)/df);ei=floor(0.8*shaftfr(bindex)/df);
        FFy(mysample,22)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS within 0.8x-1.2x
        si=floor(0.8*shaftfr(bindex)/df);ei=floor(1.2*shaftfr(bindex)/df);
        FFy(mysample,23)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS within 1.2x-3.2x
        si=floor(1.2*shaftfr(bindex)/df);ei=floor(3.2*shaftfr(bindex)/df);
        FFy(mysample,24)=sqrt(sum(P1(si:ei).*P1(si:ei))/2);
        % RMS from 0.2x - end
        si=floor(0.2*shaftfr(bindex)/df);
        FFy(mysample,25)=sqrt(sum(P1(si:end).*P1(si:end))/2);
        % RMS within 1.2x - end
        si=floor(1.2*shaftfr(bindex)/df);
        FFy(mysample,26)=sqrt(sum(P1(si:end).*P1(si:end))/2);
        % RMS within 2.75x (BFF) - end
        si=floor(2.75*shaftfr(bindex)/df);
        FFy(mysample,27)=sqrt(sum(P1(si:end).*P1(si:end))/2);

    end
    FFv=[FFx,FFy];
    save("processeddata/VelFeaturesB_"+ num2str(bindex) +'.mat','FFv')
    bindex
    
    clear FFx FFy FFv
end

