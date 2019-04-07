function D=Part1F()
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

%%
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

%%
% Definition of C matrix hardcoded.
C(1,1)=c;
C(1,2)=-c;
C(2,2)=c;
C(2,1)=-c;
C(7,7)=-L;
C
G


% Arrays for holding the values
vin=linspace(-10,10,100);
V0=zeros(length(vin),1);
V3=zeros(length(vin),1);

% Sweep through the input voltages from -10 to 10 V.
for i=1:length(vin)
    F(6)=vin(i); % Set the forcing vector row 6 to the input voltage.
    V=G\F; % Perform matrix operations to solve for the voltages in the circuit.
    V3(i)=V(3); % record the V3 node voltage
    V0(i)= -V(5); % record the V0 node voltage.
end 

% Plot the voltage on the V3 node.
figure(1)
plot(V3)
title('Output Voltage V3');
xlabel('Step #')
ylabel('Voltage (V)')

% Plot the voltage on the V0 node.
figure(2)
plot(V0)
title('Output Voltage V0');
xlabel('Step #')
ylabel('Voltage (V)')

 


% Arrays for holding the values.
f= linspace(0,50,1000);
V0 = zeros(length(f),1);
gain=zeros(length(f),1);

% Step through each frequency.
for i=1:length(f)
    S=1i*2*pi*f(i); % Calculate imaginary part.
    V=inv((G+S.*C))*F; % Calculate the voltages in the system using matrix methods.
    V0(i)=abs(V(5)); % record the voltage on the V0 node.
    gain(i) = 20*log10(abs(V(5))/abs(V(1))); % calculate and record the gain in dB.
end 

%%
% % The voltage is plotted with a log x axis for better resolution of the
% circuit's operation.

figure(3)
semilogx(f,V0);
xlabel('Frequency (Hz)')
ylabel('V0 (V)')
title('Extra Plot: Voltage vs Frequency')
%%
% The gain is plotted with a log x axis for better resolution of the
% circuit's operation.

figure(4)
semilogx(f, gain);
xlabel('Frequency (Hz)')
ylabel('Gain(dB)')
title('Gain vs Frequency');



% Arrays for storing values. 
v0 = zeros(length(f),1);
gain=zeros(length(f),1);
V = zeros(8,1);

for count=1:length(gain)
    perturbation = randn()*0.05; % Multiplying a normalized distribution by a # will alter its standard deviation according to that #.
    C(1,1)=c*perturbation; % Apply random perturbation to the capacitor
    C(2,2)=c*perturbation;
    C(1,2)=-c*perturbation;
    C(2,1)=-c*perturbation;

    s = 1i*2*pi; % angular frequency is pi.
    V=inv((G+((s).*C)))*F; % Compute the voltages of the nodes in the circuit using matrice methods.
    v0(count) = abs(V(5)); 
    gain(count) = 20*log10(abs(V(5))/abs(V(1))); % Compute the gain of the system
end
%%
% The gain is represented with a histogram giving a sense of how  sensitive the
% circuit is to random noise affecting the capacitor. 
figure;
hist(gain,80);
xlabel('Gain dB')
ylabel('Occurence #')
title('Extra Plot: Gain Sensitivity due to a Noisy Capacitor')
end