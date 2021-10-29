function [] = BeamDisplay( X, Ref )
% BeamDisplay(X, Ref);
% ECE 463 Lecture #8

x = X(1);
q = X(2);
dx = X(3);
dq = X(4);

% draw the beam

x1b = -1.9*cos(q);
y1b = -1.9*sin(q);
x2b = 1.9*cos(q);
y2b = 1.9*sin(q);

% draw the ball

i = [0:0.1:1]' * 2*pi;
xb = x*cos(q) + 0.05*cos(i)  - 0.05*sin(q);
yb = x*sin(q) + 0.05*sin(i)  + 0.05*cos(q);

% draw a line through the ball so you can see it roll

Q = -x / 0.05;
x1 = x*cos(q) - 0.05*sin(q) + 0.05*cos(Q);
y1 = x*sin(q) + 0.05*cos(q) + 0.05*sin(Q);
Q = Q + pi;
x2 = x*cos(q) - 0.05*sin(q) + 0.05*cos(Q);
y2 = x*sin(q) + 0.05*cos(q) + 0.05*sin(Q);
plot(0,0,'bo',[x1b,x2b],[y1b,y2b],'b',xb,yb,'r',[x1,x2],[y1,y2],'r-', Ref*cos(q), Ref*sin(q), 'bx');
ylim([-1.5,1.5]);
xlim([-1.5,1.5]);
pause(0.01);
hold off

end