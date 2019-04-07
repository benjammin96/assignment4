%% Part 1 & 2: Pa9 and Transient Circuit Simulation
% The goal of this assignment is to use nodal analysis techniques to
% analyse circuits. In Part 1 we are given a circuit to simulate that
% contains resistors, inductors, capacitors, voltage sources and current
% sources. To effectively model these components the KCL equations were
% written for the 5 voltage nodes and an 8x8 matrix for the real and
% imaginary values of the components was created. (G & C matrices)
%
% The first set of testing conditions were a DC voltage sweep from -10V to 10V while recording the circuit gain. An AC
% frequency sweep of 0 to 50Hz, with random pertubations on the Capacitance while recording the circuit gain.
%
% The next set of testing conditions was to perform transient analysis on
% the circuit which involved applying three distinct input signals to the
% circuit and monitoring the frequency and time domain response of the
% circuit. The three signals were: 
%
% 1. A step that transistions from 0 to 1 at 0.03s.
% 2. A sin(2pif t) function with f = 1/(0.03) 1/s
% 3. A guassian pulse with a magnitude of 1, std dev. of 0.03s and a delay
% of 0.06s
%
% The results displayed in this section are: C and G matrices, Plot of DC sweep, Plots from AC
% case of gain (Vout/Vin), Plot of Vin and Vout from numerical solution in time domain, Fourier Transform plots of Frequency response
close all 
clear all
Part1F()
Part2T()

%%
% The circuit is linear and this is demonstrated by the DC sweep. We see that the Vout is a linear function of the input voltage Vin.
%
% Inspecting the frequency sweep, the circuit's gain begins to sharply decrease around 10Hz.
% What this means is that the circuit is operating like a low pass filter.
% Lower frequencies are allowed to pass but higher frequencies are
% attenuated. 
%
% When we introduced the random perturbations on the capacitance the gain
% of the circuit is realtively consistent. This is a benefit because if the
% circuit were to be manufactured there would surely be unexpected
% parasitic capacitances and manufacturing variations. The fact that the
% circuit is not overly sensitve is a valuable characteristic of the
% circuit.

%% Part 3: Circuit with Noise
%
% In ths section of the assignment we try to model random thermal noise on
% a resistor by inserting a current source to inject the noise and a capcitor
% to limit the bandwidth of the noise. The capacitor value used was as
% given Cn=0.00001 and the noise distribution was gaussian with a maximum
% value of 0.001.
%
% The student performed analysis by recording the output of the circuit in
% the time and frequncy domain (fft). Then the student varied the value of
% Cn to observe how the bandwidth of the noise affects the circuits
% operation. Finally the student varied granularity of the time steps to observe how to it
% affected circuit operation. 
% 
Part3a()
Part3b() 

%%
% In figure 17 and 18, the noticeable addition of thermal noise can be
% seen. The effects of varying the Cn capictor were noticeable as
% increasing the value allowed for larger noise variations on the signal.
% This makes sense because the capacitor should limit noise bandwidth
% similarly to how an RC circuit dampens abrupt changes in an electrical system.
% A larger capacitor rsulted in larger noise variations and smaller
% capacitor values reduced the noise bandwidth. 
%
% As the the granularity of the time steps was increased I saw better
% resolution of the signal. The noise injected on the signal was easier to
% see at a smaller time step. Thus for maximum analysis resolution the time
% step should be small.

%% Part 4 Non Linearity
%
% Since we now have a non linear circuit response we need to modify our
% analysis methods. As seen in lecture of week 10 Circuits and MNA we
% briefly covered some non linear analysis. 
%
% Now that we have non linear components we will need to construct the
% equation from slide 20, week 10.
%
% $\hat{C}\frac{d\hat{V}}{d\hat{t}} + \hat{G}\hat{V} + \hat{B}(\hat{V}) =
% \hat{F}(t)$
% 
% The B term will contain the non linear components.
% Since our equation is non linear we have to find the solution
% iteratively. We can do this by re-formulating it as a "root" finding
% problem and use the Newton Raphson Method.
%
% Netwon Raphson Method : $x_{n+1}=x_{n} -
% \frac{f(x_{n})}{\frac{df}{dx}(x_{n})}$
% 
% We also need to form the Jacobian which contains partial derivatives of the each
% equation in B.
%
% Finally we can constuct the equation from slide 23, week 10.
%
% $(\frac{C}{\Delta t})V_{n} - \frac{C}{\Delta t}V_{n-1} - B(V) -F(t)=0$
%
% With the above equation, we will expand around Vn, form the Jacobian,
% apply the newton raphson method and and iterate for each time step to
% find the voltage. 
%
