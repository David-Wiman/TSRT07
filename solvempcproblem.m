function un = solvempcproblem(x,F,G,Mz,N,Q1,Q2,ubounds,Ts,t)

% test = 1;
% 
% if test == 1
%     x = [1,1,1,1,1,1,1,1]';
%     t = 0;
% end


global uold;

warning off;
[n,m] = size(G);


[F_fine, G_fine] = createpredictors(F, G, N);

Q1b = blockrepeat(Q1,N);
Q2b = blockrepeat(Q2,N);
Mzb = blockrepeat(Mz,N);

left_col = 0.0123*ones(round(40/Ts),1);
right_col = 0.03*ones(round(40/Ts),1);
reference_vector = [left_col right_col];

Rlong = [zeros(round(20/Ts),2) ; reference_vector ;  zeros(round(40/Ts),2)]';
k = round(t/Ts);
R = Rlong(:, k+1:k+N);
R = reshape(R,1,[])';

% R = 2*ones(N,1);

Au = [eye(N*m);-eye(N*m)];

bu = [repmat(ubounds(:,2),N,1);repmat(-ubounds(:,1),N,1)];

%bu = [ubounds(2)*ones(N*m,1);-ubounds(1)*ones(N*m,1)]; % Uppgift 1

Omega = eye(N*m)-[zeros(m,N*m);eye((N-1)*m) zeros((N-1)*m,m)];

delta = [uold;zeros((N-1)*m,1)];

options = optimset('Display','off');

U = quadprog(G_fine'*Mzb'*Q1b*Mzb*G_fine+Omega'*Q2b* ...
    Omega, G_fine'*Mzb'*Q1b*(Mzb*F_fine*x-R)-Omega'*Q2b*delta,Au,bu,[],[],[],[],[],options);


% U = quadprog(G_fine'*Mb'*Q1b*Mb*G_fine+Q2b,
% G_fine'*Mb'*Q1b*Mb*F_fine*x,Au,bu,[],[],[],[],[],options); % Uppgift 1

un = U(1:m);
uold=un;

end