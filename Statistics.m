clc; close; clear
%% This template can be used for statistical analysis purposes
% Arian Velayati


%% Load data
Data = readtable('Data1_y.csv','PreserveVariableNames',true);
Data = table2array(Data);
Kid_age = Data(:,1); %first data set 
Kid_fage = Data(:,2); %second dataset

%% Initial assessment of the data

% Data centrality measures

% Average (A good measure of centrality for the symmetric data)
M1 = mean(Kid_age);
M2 = mean(Kid_fage);

%Median( A good measure of centrality for the non-symmetric data)
Med1 = median(Kid_age);
Med2 = median(Kid_fage);

%Mode 
mod1 = mode(Kid_age);
mode2 = mode(Kid_fage);

% Measures of spread

%Variance
Var1 = var(Kid_age);
Var2 = var(Kid_fage);

%Standard deviation
ST1 = std(Kid_age);
ST2 = std(Kid_fage);

%Interquartile ranege (the distance between the 25th and 75th percentile in
%the data (width of the middle 50% of the values)
IQ1 = iqr(Kid_age);
IQ2 = iqr(Kid_fage);

%Range
R1 = range(Kid_age);
R2 = range(Kid_fage);

% max and min
Max1 = max(Kid_age);
Max2 = max(Kid_fage);
Min1 = min(Kid_age);
Min2 = min(Kid_fage);


%% Data skewness
if abs(M1-Med1) < 2
    disp("Normal distribution")
elseif    M1>Med1 && Med1>mod1
    disp("The data is skewed to the right")
elseif mod1>Med1 && Med1>M1
        disp("The data is skewed to the left")
else
    disp("check the histogram")
end

%% Visualizations 
% Boxplots
figure(1)
subplot(1,2,1)
B1 = boxplot(Kid_age);
title("1st dataset")
subplot(1,2,2)
B2 = boxplot(Kid_fage);
title("2nd dataset")

% Histograms
figure(2)
H1 = histogram(Kid_age);
xlabel("Values")
ylabel("Frequency")

hold on
H2 = histogram(Kid_fage);
hold off
legend("1st dataset","2nd dataset")


%Normal PDF
figure(3)
histogram(Kid_age,"normalization","pdf");
ylabel("Probability")
xlabel("Value")
hold on
histogram(Kid_fage,"normalization","pdf");
hold off
legend("1st dataset","2nd dataset")


%% Interpolation

x1 = 9; %starting point of the sampling
x2 = 11; %The end point of the sampling
n = 10; % number of evenly spaced samples

xNew = linspace(x1,x2,n);   %Sampling daata points for interpolation at desired x values

yNew = interp1(Kid_age,Kid_fage,xNew,"pchip"); % x&y are known in the data sets, xnew is the sampling points where you want the interpolation to be done
% other interp methods include: pchip (no oscillations); spline (cubic polynomials);next; previous; nearest


figure(4)
scatter(Kid_age,Kid_fage)
hold on 
plot(xNew,yNew,"o")  %plotting the interpolated values and adding them to the current plot
hold off

%% Regression and correlations
% Correlations

%Matrix of pearson correl coefficients
C = corrcoef(Kid_age,Kid_fage);

figure(5)
C2 = corrplot(Data);

% Linear Regression
[Yfit,gof] = fit(Kid_age,Kid_fage,"poly2");
r2 = gof.rsquare
% Other types of fit
% 'poly1' % % Linear polynomial curve
% % 'poly11'%  % Linear polynomial surface
% % 'poly2'% % Quadratic polynomial curve
% % 'linearinterp'% % Piecewise linear interpolation
% % 'cubicinterp'% % Piecewise cubic interpolation
% % 'smoothingspline'% % Smoothing spline (curve)
% % 'lowess'% % Local linear regression (surface)

figure(6)
subplot(1,2,1)
plot(Yfit,Kid_age,Kid_fage)
subplot(1,2,2)
plot(Yfit,Kid_age,Kid_fage,"residuals")

%Non-linear regression
%Normalizing the data (Zero-mean normalization)
Kid_age2 =Kid_age-mean(Kid_age);
Kid_fage2 = Kid_fage - mean(Kid_fage);
[Yfit2,gof2] = fit(Kid_age2,Kid_fage2,"sin2");
r2_2 = gof2.rsquare

figure(7)
subplot(1,2,1)
plot(Yfit2,Kid_age2,Kid_fage2)
subplot(1,2,2)
plot(Yfit,Kid_age2,Kid_fage2,"residuals")
