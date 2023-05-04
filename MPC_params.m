

load distilldata

global uold

dim_x = size(A,1);
dim_u = size(B,2);

C = eye(dim_x);
D = zeros(dim_x,dim_u);

Gss = ss(A,B,C,D);
%M = eye(2); Uppgift 1

x0 = xstar;
%x0 = [0.98 0.90 0.76 0.53 0.37 0.20 0.08 0.02]'; Uppgift 1

Ts = 1; % Ändra vid behov

Gss_disc = c2d(Gss, Ts);
F = Gss_disc.A;
G = Gss_disc.B;

N = 5; % Ändra vid behov
Q1 = diag([10000000 10000000]);
Q2 = diag([0.1 0.1]);

ubounds = [-2 3; -2.5 2.5];


% Uppgift 1, N = 5, Q1 = diag([100   10]), Q2 = diag([0.1 0.01]), ubounds = [-2 3; -2.5 2.5]

% Uppgift 2, N = 5, Q1 = diag([10000000 10000000]), Q2 = diag([0.1 0.1]), ubounds = [-2 3; -2.5 2.5]

uold = [0 0]';
