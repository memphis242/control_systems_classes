% options = optimoptions('fmincon',...
%     'PlotFcn','optimplotfvalconstr',...
%     'Display','iter');
options = optimoptions('fmincon',...
    'MaxFunctionEvaluations', 30e3);
X0 = [5e-3,1,1];
A=[]; b=[]; Aeq=[]; beq=[]; lb=[]; ub=[];

[X,fval] = fmincon(@(X) err2(X), X0, A,b,Aeq,beq,lb,ub,@(X) const2(X),options)