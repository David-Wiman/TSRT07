data = iddata(pt,ct,Ts);
data.InputName  = '\Delta CTemp';
data.InputUnit  = 'C';
data.OutputName = '\Delta PTemp';
data.OutputUnit = 'C';
data.TimeUnit   = 'minutes';

G = tfest(data,1); % Estimate however but with 1 pole

G  = procest(data,'P1D'); % Estimate as first order system with delay

compare(data,G)