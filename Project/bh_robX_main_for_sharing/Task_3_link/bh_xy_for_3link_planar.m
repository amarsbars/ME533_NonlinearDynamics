function out1 = bh_xy_for_3link_planar(L_1,L_2,L_3,theta_1,theta_2,theta_3)
%BH_XY_FOR_3LINK_PLANAR
%    OUT1 = BH_XY_FOR_3LINK_PLANAR(L_1,L_2,L_3,THETA_1,THETA_2,THETA_3)

%    This function was generated by the Symbolic Math Toolbox version 7.0.
%    15-Sep-2016 12:19:34

t2 = theta_1+theta_2;
t3 = theta_1+theta_2+theta_3;
out1 = [L_2.*cos(t2)+L_3.*cos(t3)+L_1.*cos(theta_1),L_2.*sin(t2)+L_3.*sin(t3)+L_1.*sin(theta_1)];