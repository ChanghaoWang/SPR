% Robust Point Matching (RPM) Demo (version 20000427):
% ----------------------------------------------------
% Copyright (C) 2000 Haili Chui, Anand Rangarajan
% 
% Authors: Haili Chui and Anand Rangarajan
% Date:    04/27/2000
% 
% Contact Information:
%
% Haili Chui:		chui@noodle.med.yale.edu
% Anand Rangarajan:	anand@noodle.med.yale.edu
% 
% Terms:	  
% 
% The source code (M-files) are provided under the
% terms of the GNU General Public License with an explicit
% clause permitting the execution of the M-files from within
% a MATLAB environment. See the LICENSE file for details.
%
%


% rpm_demo_cmd.m
% ------------------------------------------------------------------- 
% Robust Point Matching Demo.
% 
% Purpose: 
%     1. Script to run various demo examples.
%     2. Provide same functions as "rpm_demo.m" except
%        that there is no GUI, only runs RPM.
% Usage:
% rpm_demo_cmd (1);  -- run example1.
% rpm_demo_cmd (2);  -- run example2.
% rpm_demo_cmd (3);  -- run example2.
% rpm_demo_cmd (4);  -- run example1.
% rpm_demo_cmd (5);  -- run example2.
%
% Notes: There are a total of 5 examples included to demonstrate 
%        the non-rigid point matching algorithm.
% ------------------------------------------------------------------- 
% Last modified: 04/27/00

function [] = rpm_demo_cmd (cmd_str);

if nargin < 1
  disp ('# ERROR #: you need to input the demo example name');
  help rpm_demo_cmd; break;
end;

% clean up figures:
figure(1); delete(1); 
figure(2); delete(2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load data:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch (cmd_str)
  case 1
    rpm_demo('reset_all'); load demodata_ex1;
    x = x1; y = y1; 
    demo_disp(x,y); cpause; 
  case 2
    load demodata_ex2;
    x = x2; y = y2; 
    demo_disp(x,y); cpause; 
  case 3
    load demodata_ex3;
    x = x3; y = y3; 
    demo_disp(x,y); cpause; 
  case 4
    load demodata_ex4;
    x = x1*2; y = y2a*2; 
    demo_disp(x,y); cpause; 
  case 5
    load demodata_ex5;
    x = x1; y = y2a; 
    demo_disp(x,y); cpause; 
  otherwise
    disp ('# ERROR #: rpm_demo_cmd -- no such example found !');
    help rpm_demo_cmd; break;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Run RPM:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters:
frac       = 1;
T_init     = 0.5;
T_finalfac = 500;

[c,d,m] = cMIX (x,y,frac,T_init, T_finalfac);
disp ('RPM point matching done ...');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dispaly two point sets:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = demo_disp (x,y);

fig(1); clf; 
cplot(x,y); hold on; 

jnk  = axis; fac = 10;
xmin = jnk(1); xmax = jnk(2); ymin = jnk(3); ymax = jnk(4);
xmin = xmin - (xmax-xmin)/fac;
xmax = xmax + (xmax-xmin)/fac;
ymin = ymin - (ymax-ymin)/fac;
ymax = ymax + (ymax-ymin)/fac; axis_save = [xmin xmax ymin ymax];

[jnk,itmp] = max(x(:,2)); 
pttmp      = x(itmp,:); 
htmp       = text (pttmp(1,1), pttmp(1,2)+(ymax-ymin)/fac/2, 'Template Point Set'); 
set        (htmp, 'color', 'g', 'fontsize', 15);
[jnk,itmp] = max(y(:,2)); 
pttmp      = y(itmp,:); 
htmp       = text (pttmp(1,1), pttmp(1,2)+(ymax-ymin)/fac/2, 'Data Point Set'); 
set        (htmp, 'color', 'r', 'fontsize', 15);

axis(axis_save); axis('off');




