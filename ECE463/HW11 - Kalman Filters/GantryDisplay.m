function [] = GantryDisplay(X, Ref)
% GantryDisplay(X, Ref)
% ECE 463 Lecture #7

x = X(1);
q = X(2);
% cart
xc = [-0.2,0.2,0.2,-0.2,-0.2] + x;
yc = [0,0,0.2,0.2,0];
xm = x + sin(q);
ym = 0 - cos(q);
% ball
hold off
q = [0:0.1:1]' * 2*pi;
xb = 0.05*cos(q) + xm;
yb = 0.05*sin(q) + ym;
plot([-3,3],[0,0],'b-',xc, yc,'r-',[x,xm],[0,ym],'r-',xb, yb, 'r-',[Ref, Ref],[-0.1,0.1],'b')
ylim([-1.5,0.5]);
pause(0.01);
end