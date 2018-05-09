function [ r ] = my_eps( d )
%UNTITLED21 此处显示有关此函数的摘要
%   此处显示详细说明
d=abs(d);
if ((d==inf) || isnan(d))
    r=NaN;
    return;
end
bytes=typecast(d,'uint8');
e=typecast(bytes(end-1:end),'uint16');
switch class(d)
    case 'double',
        bs=4;
        subnum=52;
        zeronum=6;
        le_rmin=2^(-1074);
    case 'single',
        bs=7;
        subnum=23;
        zeronum=2;        
        le_rmin=2^(-149);
    otherwise,
        error('Only Single & Double classes are supported!');
end

if (d<=realmin(class(d)))
    r=le_rmin;
    return;
end
e=bitshift(e,-bs)-subnum;
e=bitshift(e,bs);
e=typecast(e,'uint8');
r=typecast([zeros(1,zeronum,'uint8') e],class(d));


end

