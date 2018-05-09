function [peakloc] = initial_rr( data,fs )
 %x: vector of input data
 % fs: sampling rate
 % peaks: vector of R-peak impulse train
  winlen =0.15; % 150ms
  fp1 = 10;
  fp2 = 33.3;
  thr = 0.2;
  flag = abs(max(data))>abs(min(data));
  N = length(data);
  data = data(:);

% L1 = round(fs/fp2);    % first zero of the LP filter is placed at f = 33.3Hz;
% L2 = round(fs/fp1);    % first zero of the HP filter is placed at f = 3Hz;
% 
% fprintf(1, '.');

% x0 = data - Median(data',N,round(fs*winlen/3));

% q = ceil(fs/150);
% N_padded = (ceil(N / q) * q);
% data = [data; zeros(N_padded-N,1)];
% data = data - resample(MedianFilt(resample(data,1,q), round(fs*winlen/3/q)), q, 1);
% data = data(1:N);
% x0 = data;

% fprintf(1, '.');
% 
% % LP filter
% x = filter([1 zeros(1,L1-1) -1],[L1 -L1],data);
% x = filter([1 zeros(1,L1-1) -1],[L1 -L1],x);
% x = [x(L1:end);zeros(L1-1,1) + x(end)]; % lag compensation
% 
% fprintf(1, '.');
% 
% % HP filter
% y = filter([L2-1 -L2 zeros(1,L2-2) 1],[L2 -L2],x);
y=data;

% differentiation
z = diff([y(1) ; y]);

% squaring
w = z.^2;

fprintf(1, '.');

% moving average
L3 = round(fs*winlen);
v = filter([1 zeros(1,L3-1) -1],[L3 -L3],w);
v = [v(round(L3/2):end);zeros(round(L3/2)-1,1) + v(end)]; % lag compensation

vmax = max(v);
p = v > (thr*vmax);

fprintf(1, '.');

% edge detection
rising  = find(diff([0 ; p])==1);      % rising edges
falling = find(diff([p ; 0])==-1);     % falling edges

if( length(rising) == length(falling)-1 ),
    rising = [1 ; rising];
elseif( length(rising) == length(falling)+1 ),
    falling = [falling ; N];
end

fprintf(1, '.');

peakloc = zeros(length(rising),1);
width = zeros(length(rising),1);

Nrising = max(1, length(rising)/20);
j = 0;


if(flag)
    for i=1:length(rising)
        
        if( j > Nrising)
            fprintf(1, '.');
            j = 0;
        else
            j = j + 1;
        end
        
        [val, mx] = max( data(rising(i):falling(i)) );
      
        peakloc(i) = mx - 1 + rising(i);
        width(i) = falling(i) - rising(i);
        
       
    end
else
    for i=1:length(rising)
        if( j > Nrising)
            fprintf(1, '.');
            j = 0;
        else
            j = j + 1;
        end
        
        [val mn] = min( data(rising(i):falling(i)) );
        peakloc(i) = mn - 1 + rising(i);
        width(i) = falling(i) - rising(i);
    end
end
fprintf(1, '\n');

end

