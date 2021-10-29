function J = cost3(z)
% ECE 463 lecture #23
% Calculate the shape of a soap film
 
    a = z(1);
    b = z(2);
    M = z(3);
 % assume gravity is in the -y direction
 % y = f(x)
    Length = 4;
    x1 = 0;
    y1 = 6;
    x2 = 2;
    y2 = 5;
 
    e1 = a*cosh((x1-b)/a) - M - y1;
    e2 = a*cosh((x2-b)/a) - M - y2;
    e3 = a*sinh((x2-b)/a) - a*sinh((x1-b)/a) - Length;

    x = [x1:0.001:x2]';
    y = a*cosh( (x-b)/a ) - M;
%     plot(x,y);
%     xlim([x1,x2]);
%     ylim([0,2]);
%     pause(0.01);
    J = e1^2 + e2^2 + e3^2;
 
 end