function [fitresult, gof] = createFit1(X, ni)
%CREATEFIT1(X,NI)
%  Create a fit.
%
%  Data for 'surface water resources' fit:
%      X Input : X
%      Y Output: ni
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 30-Jan-2016 13:51:44


%% Fit: 'surface water resources'.
[xData, yData] = prepareCurveData( X, ni );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf];
opts.StartPoint = [335.309114236779 -0.0700624221196175];
opts.Upper = [Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'surface water resources' );
h = plot( fitresult, xData, yData );
legend( h, 'ni vs. X', 'surface water resources', 'Location', 'NorthEast' );
% Label axes
xlabel( 'Year' );
ylabel( 'water resources/hundred million m3' );

grid on


