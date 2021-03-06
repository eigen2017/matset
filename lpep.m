function Hd = lpep
%LPEP Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.4 and the Signal Processing Toolbox 6.22.
% Generated on: 11-Jan-2018 19:32:05

% FIR least-squares Highpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 200;  % Sampling Frequency

N     = 40;   % Order
Fstop = 0.7;  % Stopband Frequency
Fpass = 1;    % Passband Frequency
Wstop = 3;    % Stopband Weight
Wpass = 3;    % Passband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fstop Fpass Fs/2]/(Fs/2), [0 0 1 1], [Wstop Wpass]);
Hd = dfilt.dffir(b);

% [EOF]
