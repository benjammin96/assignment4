function D = Part2T()
clear all

G=zeros(8,8);
C=zeros(8,8);
F=zeros(8,1);

% Definition of circuit elements
R1 = 1; 
R2=2;
R3=10;
R4=0.1;
R0=1000;
c=0.25;
L=0.2;
a = 100;


% Definition of G matrix hardcoded.
G(1,1)=1/R1;
G(1,2)=-1/R1;
G(2,1)=-1/R1;
G(2,2)=1/R1 +1/R2;
G(3,3)=1/R3;
G(4,4)=1/R4; 
G(4,5)=-1/R4;
G(5,4)=1/R4;
G(5,5)=1/R4 +1/R0;
G(6,1)=1;
G(7,2)=1;
G(7,3)=-1;
G(8,3)=-a/R3;
G(8,4)=1;
G(1,6)=1;
G(2,7)=1;
G(3,7)=-1;
G(4,8)=1;


% Definition of C matrix hardcoded.
C(1,1)=c;
C(1,2)=-c;
C(2,2)=c;
C(2,1)=-c;
C(7,7)=-L;


%%

simt=1; % time in seconds 
nsteps=1000; % number of time steps

dt=simt/nsteps; % dt 
V(1:8,1)=[0;0;0;0;0;0;0;0];
M=(C./dt+G);
for step=1:nsteps 
    t=step*dt;
    if(t>0.03) % Controls Input Step Voltage
      Vin=1;  
    else
      Vin=0;
    end
    F(6)=Vin;
    B=C*V(1:8,step)./dt+F;
    V(1:8,step+1)=M\B; % Voltage outputs for the network
end


figure(5)
plot(V(1,:))
title('Voltage Input Signal 1) ')
xlabel('Time step ')
ylabel('Voltage V')

figure(6)
plot(-V(5,:))
title('Voltage Output Signal 1) ')
xlabel('Time step')
ylabel('Voltage V')

Yin = fft(V(1,:)); % fast fourier transform
Yout = fft(V(5,:)); % fast fourier transform

figure(7)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yin)),fftshift(abs(Yin)))
%fft shift rearranges a Fourier transform X by shifting the zero-frequency component to the center of the array.
title('Frequency Domain Input Signal 1)')
xlabel('Freq Hz')
ylabel('Power')

figure(8)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yout)),fftshift(abs(Yout))) 
%fft shift rearranges a Fourier transform X by shifting the zero-frequency component to the center of the array.
title('Frequency Domain Output Signal 1)')
xlabel('Freq Hz')
ylabel('Power')

%% 

simt=1; 
nsteps=1000;
f= 1/0.03; % freq in hertz
dt=simt/nsteps;
M=(C./dt+G);
V(1:8,1)=[0;0;0;0;0;0;0;0];

for step=1:nsteps
    t=step*dt;
    Vin=sin(2*pi*f*t);
    F(6)=Vin;
    B=C*V(1:8,step)./dt+F;
    V(1:8,step+1)=M\B;
end

figure(9)
plot(V(1,:));
title('Voltage Input Signal 2) ')
xlabel('Time step')
ylabel('Voltage V')

figure(10)
plot(-V(5,:));
title('Voltage Output Signal 2) ')
xlabel('Time step')
ylabel('Voltage V')

Yin = fft(V(1,:));
Yout = fft(V(5,:));

figure(11)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yin)),fftshift(abs(Yin)))
title('Frequency Domain Input Signal 2)')
xlabel('Freq Hz')
ylabel('Power')

figure(12)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yout)),fftshift(abs(Yout)))
title('Frequency Domain Output Signal 2)')
xlabel('Freq Hz')
ylabel('Power')


%% 

simt=1; 
nsteps=1000;
f=1/0.03;
dt=simt/nsteps;
M=(C./dt+G);
V(1:8,1)=[0;0;0;0;0;0;0;0];
Gaussian=@(t) exp(-(t-0.1)^2/(2.*0.03^2));

for step=1:nsteps
    t=step*dt;
    Vin=Gaussian(t);
    F(6)=Vin;
    B=C*V(1:8,step)./dt+F;
    V(1:8,step+1)=M\B;
end

figure(13)
plot(V(1,:));
title('Voltage Input Signal 3) ')
xlabel('Time step')
ylabel('Voltage V')

figure(14)
plot(-V(5,:));
title('Voltage Output Signal 3) ')
xlabel('Time step')
ylabel('Voltage V')

Yin = fft(V(1,:));
Yout = fft(V(5,:));

figure(15)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yin)),fftshift(abs(Yin)))
title('Frequency Domain Input Signal 3)')
xlabel('Freq Hz')
ylabel('Power')

figure(16)
plot(linspace(-1/dt*0.25,1/dt*0.25,length(Yout)),fftshift(abs(Yout)))
title('Frequency Domain Output Signal 3)')
xlabel('Freq Hz')
ylabel('Power')
end
