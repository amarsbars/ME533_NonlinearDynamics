function out1 = Lagrangian_C(l1,l2,m2,th2,th1_D,th2_D)
%LAGRANGIAN_C
%    OUT1 = LAGRANGIAN_C(L1,L2,M2,TH2,TH1_D,TH2_D)

%    This function was generated by the Symbolic Math Toolbox version 8.1.
%    06-Jun-2018 16:09:55

t2 = sin(th2);
out1 = reshape([-l1.*l2.*m2.*t2.*th2_D,l1.*l2.*m2.*t2.*th1_D.*(1.0./2.0),l1.*l2.*m2.*t2.*th2_D.*(-1.0./2.0),0.0],[2,2]);
