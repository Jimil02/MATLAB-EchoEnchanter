%Digital Communication Project
%20BCE107 Jimil Hiteshkumar Patel
%20BCE092 Himanshu Vadher
%20BCE103 Chetan Jani
%20BCE094 Priyank Isadara

clc      %In order to clear command window
clear all    %Clear workspace
close all    %Closes all the windows (eg. Graph window)
warning off  %Skips the display of any warnings

[x,Fs] = audioread('Sample.wav'); %Reads the .wav file and returns array and Frequency

p1 = audioplayer(x, Fs); %Converts the array into audioplayer
disp("Original Sound is...");  %Normal print function

xft = fft(x);  %'fft : Fast Fourier Tranformation'
xabs = abs(xft); %'fft' returns complex values and hence to make the value absolute 'abs' is used

x1 = x(:,1);  %converts the array into a vector
dt = 1/Fs;  %Time period calculation
t = 0:dt:(length(x)*dt)-dt; %Total time of audio

subplot(2,2,1); %Converts the graph window into 2 by 2 matrix for display
plot(t, x); %Plotting the amplitude vs time graph
title('Amplitude Vs Time(Original)'); %Add title to graph
xlabel('Time(Sec)'); %Add x label 
ylabel('Amplitude'); %Add y label

subplot(2,2,2); 
plot(t, xabs);
title('Frequency Vs Time(Original)');
xlabel('Time(S)');
ylabel('Frequency');

play(p1); %play p1 audioplayer
pause; %Pauses until 'Enter' is pressed

num = [1, zeros(1,4800), 0.4, zeros(1,5000), 0.6]; %Numerator array with a delay in between (zeros array)
den = 1; %Denominator for the z tranform

y = filter(num, den, x); %filter function for adding echo
p2 = audioplayer(y, Fs); %converting y's array into audioplayer
disp("Echo Added Signal...");

yft = fft(y);
yabs = abs(yft);

subplot(2,2,3);
plot(t, y);
title('Amplitude Vs Time(Echoed)');
xlabel('Time(S)');
ylabel('Amplitude');

subplot(2,2,4);
plot(t, yabs);
title('Frequency Vs Time(Echoed)');
xlabel('Time(S)');
ylabel('Frequency');

play(p2);

audiowrite('Echoed.wav', y, Fs); %writing .wav file with frequency of x
