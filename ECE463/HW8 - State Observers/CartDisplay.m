function [] = CartDisplay(X, Ref)
% Cart Display
% ECE 463 Lecture #7

x = X(1);
q = X(2);
% cart
xc = [-0.2,0.2,0.2,-0.2,-0.2] + x;
yc = [0,0,0.2,0.2,0];
xm = x + sin(q);
ym = 0 + cos(q);
% ball
q = [0:0.1:1]' * 2*pi;
xb = 0.05*cos(q) + xm;
yb = 0.05*sin(q) + ym;
plot([-3,3],[0,0],'b-',xc,yc,'r-',[x,xm],[0,ym]+0.2,'r-',xb, 0.2+yb, 'r-',[Ref, Ref],[-0.1,0.1],'b')
ylim([-0.5,1.5]);
pause(0.01);
end