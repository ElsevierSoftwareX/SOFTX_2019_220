function [Net]=visibilitynet(xn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N=length(xn);
txV=[1:1:N]';
xV=xn;
for i=1:N
    if (i<N)
        Net(i,i+1)=1;
        Net(i+1,i)=1; 
    end
end
for i=1:N
    for j=(i+2):N
        Dyt(i,j)=(xV(j)-xV(i))/(txV(j)-txV(i));
        Net(i,j)=1;    
        Net(j,i)=1; 
        for k=(i+1):(j-1)   
            temp(k) = xV(i) + Dyt(i,j)*(txV(k)-txV(i)); 
            if temp(k) <= xV(k) 
                Net(i,j) = 0;
                Net(j,i) = 0; 
                break 
            end
        end
    end
end


