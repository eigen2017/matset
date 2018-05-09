function Hd = iir2
%IIR2 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.4 and the Signal Processing Toolbox 6.22.
% Generated on: 12-Jan-2018 10:01:07

% Elliptic Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 200;  % Sampling Frequency

N     = 4;   % Order
Fpass = 2;   % Passband Frequency
Apass = 1;   % Passband Ripple (dB)
Astop = 80;  % Stopband Attenuation (dB)

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.highpass('N,Fp,Ast,Ap', N, Fpass, Astop, Apass, Fs);
Hd = design(h, 'ellip');

% [EOF]