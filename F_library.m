% IMC
% G = Kp/(s*T+1)
Kp = 1;
T = 1;
Tc = 1; % Desired time constant
F = (T/(Kp*Tc))*(1+1/(T*s));

% IMC
% G = (Kp/(s*T+1))*exp(-s*L)
Kp = 1;
T = 1;
L = 1;
Tc = 1; % Desired time constant

K = ( (T+L/2) / ( Kp*(Tc+L) ) );
Ti = (T+L/2);
Td = ( T*L / ( 2*(T+L/2) ) );
mu = 0.1;

F = K*( 1 + 1/(Ti*s) + Td*s/(mu*Td*s + 1) );

% Lambda trimming
% G = (Kp/(sT+1))*exp(-s*L)
Kp = 1;
T = 1;
L = 1;
lambda = 1;
F = T/(Kp*(lambda*T+L))*( 1 + 1/(T*s) );

% pidtune(G, 'PIDF')

F = Kp + Ki/s + Kd*s/(Tf*s+1);