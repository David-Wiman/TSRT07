s = tf('s'); % Create a Laplace variable
Kp = 0;
Ki = 0;
Kd = 0;
Ts = 0;
omega = 0;
freq = 0;

%Ts = 2*pi/omega;
%Ts = 1/freq;

G = (2*s + 1)/(s^3 + 3*s^2 + 4*s + 1); % Create a transfere function
G = tf([2,1], [1,3,4,1]); % Create a transfere function

F = Kp + (Ki / s) + (Kd * s)/(s*Ts + 1);
F = pidtune(G,'PID'); % Creates a good regulator for system G, see help for options

Gc = feedback(F*G, 1); % Closed loop system

O = obsv(Gss.A, Gss.C);
is_obs = (rank(O) == length(Gss.A)); % Check if observable

C = ctrb(Gss.A, Gss.B);
is_ctrb = (rank(C) == length(Gss.A)); % Check if controllable

rlocus(G); % rlocus of the open system, gives us stability to Kp*G

nyquist(G); % % Crosses the real axis at -x => 1/x gives us the critical gain Ku

Gd = c2d(G, 0.5); % Discrete varaiant of G with Ts = 0.5

Gss = ss(G); % State space form of G, Gss.A gives the A matrix

G = tf(Gss); % Transfer function from state space

step(G, 'r', Gc, 'b');
grid;
legend;
xlim([0 Tend])

% Gsp = Kp/(1+s*T)*exp(-s*L); Estimation of a stable system

H = tf([1 0], [1 -0.9], Ts); % Make a discrete system without a continuous system first

% Find theoretical minimum variance of output signal
w = impulse(H, d*Ts)*Ts;
sigma_min = sum(w.*w)*variance;

Harris_index = var_y/sigma_min;