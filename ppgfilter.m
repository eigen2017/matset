clear all
clc
ff=[0.9960975909694,  -0.9960975909694];
tt=[  1,  -0.9921951819388];
xx = load('C:\Users\pc20150817\Documents\Tencent Files\1181672105\FileRecv\led3-ldo-d.txt');
dff=filtfilt(ff,tt,xx);
nn = smooth(dff);