function D = Part3b()
clear all

Cn=[0.01;0.0001;0.000001]; % capacitance values
for i=1:3
    
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
cn=Cn(i);


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
C(3,3)=cn;
C(2,1)=-c;
C(7,7)=-L;

simt=1; 
nsteps=1000;
f=1/0.03;
dt=simt/nsteps;
M=(C./dt+G);
V(1:8,1)=[0;0;0;0;0;0;0;0];

Gaussian=@(t) exp(-(t-0.1)^2/(2.*0.03^2));

for step=1:nsteps 
    In=randn()*0.001;
    t=step*dt; 
    Vin=Gaussian(t);
    F=[0; 0; -In; 0; 0; Vin;0;0];
    B=C*V(1:8,step)./dt+F;
    V(1:8,step+1)=M\B;
end

    figure(i+20)
    hold on
    plot(-V(6,:));
    plot(-V(5,:));
    xlabel('Time step')
    ylabel('Voltage V')
    legend('Output V','Input V')
    title(strcat('cn: ',num2str(Cn(i)),' Farad'))
end

%% 
clear V
ts=[100;1000;50000]; % time values
for i=1:3
    
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
cn=0.00001; % Set Cn value to original

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
C(3,3)=cn;
C(2,1)=-c;
C(7,7)=-L;

simt=1; % sec
nsteps=ts(i);
f=1/0.03;
dt=simt/nsteps;
M=(C./dt+G);
V(1:8,1)=[0;0;0;0;0;0;0;0];
Gaussian=@(t) exp(-(t-0.1)^2/(2.*0.03^2));

for step=1:nsteps 
    In=randn()*0.001;
    t=step*dt;
    Vin=Gaussian(t);
    F=[0; 0; -In; 0; 0; Vin;0;0];
    B=C*V(1:8,step)./dt+F;
    V(1:8,step+1)=M\B;
end

    figure(i+23)
    hold on
    plot(-V(6,:));
    plot(-V(5,:));
    xlabel('Time step')
    ylabel('Voltage V')
    legend('Output V','Input V')
    title(strcat('timestep: ',num2str(ts(i)),' steps'))
end
end