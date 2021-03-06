function Hd = PPG15
%PPG15 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.4 and the DSP System Toolbox 8.7.
% Generated on: 01-Dec-2017 15:57:05

% FIR least-squares Lowpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 100;  % Sampling Frequency

N     = 20;  % Order
Fpass = 13;  % Passband Frequency
Fstop = 16;  % Stopband Frequency
Wpass = 1;   % Passband Weight
Wstop = 6;   % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);
Hd = dfilt.dffir(b);

% [EOF]
