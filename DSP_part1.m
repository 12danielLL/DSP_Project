%%%PART 1
%%Q2-C
fs = 60; % Sampling frequency in Hz, which fits the critiria.
N_in = 1947; % Number of input samples, we calculated the needed size.
N_out = 2048; % Number of output samples
t = (0:N_in-1)*(1/fs);% Creating the time values
t2=linspace(0,32.45,1947);
r = cos(2*pi*5*t)+cos(2*pi*10*t); % Creating the signal r(t)
load('filter_0.25_101.mat','h'); % Load the filter
% The FFT on r will give us a signal with 2048 samples which is the size
% requested for the output, we than want to mult it by the FFT of h, in order
% to do that we need the leangth of the filter and the signal to be the same,
% so we will pad h. 
h_padded = [h, zeros(1, N_out - length(h))];
R=custom_fft(r);
H_Pad=custom_fft(h_padded);
S=R.*H_Pad;
% Frequency vector for the x-axis, as we learned in class we have a change in the
% freq axis in the grapic represantaion, so we create it.
f = (0:N_out-1) * (fs / N_out);
figure;
plot(f, abs(S));
xlabel('frequency');
ylabel('|S[k]|');
title('Magnitude of the FFT of the Filtered Signal');
grid on;
%done
%% Q3-A
% Loading the signal and filters from the files given
sig = load('sig_x.mat');
x_FULL = sig.x;
x=x_FULL(1:18000);
filter1 = load('filter_1.mat');
h1 = filter1.xx;
filter2 = load('filter_2.mat');
h2 = filter2.xx;
% Plotting the signal
figure;
plot(x);
title('Signal x[n]');
xlabel('Samples');
ylabel('Amplitude');
% Sampling rate
fs = 18000;  % Hz
X = custom_fft(x);
% Creating the freq axis, as we learned in class we have a change in the
% freq axis in the grapic represantaion, so we create it.
frequencies = (0:length(X)-1)*(fs/length(X));
% Plot the mag of the FFT
figure;
plot(frequencies(1:floor(length(frequencies))), abs(X(1:floor(length(X)))));
title('FFT of x[n]');
xlabel('frequency (Hz)');
ylabel('|X|');
%done
%% Q3-B presenting the FFT of the filters
%FFT on the filters
H1=fft(h1);
H2=fft(h2);
%Plot the mag of the filters
figure;
subplot(2,1,1);
plot(abs(H1));
title('FFT of h1');
xlabel('frequency');
ylabel('|H_1|');
subplot(2,1,2);
plot(abs(H2));
title('FFT of h2');
xlabel('frequency');
ylabel('|H_2|');
%done
%% Q3-C direct linear convolution between the filters and the signal
y1_direct = manual_conv(x, h1);
y2_direct = manual_conv(x, h2);
% plotting the covolution between the signals
figure;
subplot(2,1,1);
plot(y1_direct(1:500));
title('Linear Convolution Result with h1[n]');
xlabel('samples');
ylabel('y[n]'); 
subplot(2,1,2);
plot(y2_direct(1:500));
title('Linear Convolution Result with h2[n]');
xlabel('samples');
ylabel('y[n]');
%done
%% Q3-D 
% Creating diffreant frame sizes.
L=[64,128,256,512,1024];
timeOVAconv1=zeros(1,length(L));
timeOVAconv2=zeros(1,length(L));

% Running on each frame size, checking the ova conv for both of the filters
% and saving the results.
for i = 1:length(L)
    tic;
    y1=ova_conv(x,h1,L(i));
    timeOVAconv1(i)=toc;
    tic;
    y2=ova_conv(x,h2,L(i));
    timeOVAconv2(i)=toc;
    % We're also saving the time for each frame size.
end
% Plotting the results.
t=0:1:18060-1;
figure;
subplot(2,1,1)
plot(t(1:500),y1(1:500),t(1:400),y1_direct(1:400))
title('Linear VS. OVA convolution - H1');
xlabel('samples');
ylabel('y[n]');
legend('Linear - h1', 'OVA - h1');
grid on;
subplot(2,1,2)
plot(t(1:500),y2(1:500),t(1:400),y2_direct(1:400))
title('Linear VS. OVA convolution - H2');
xlabel('samples');
ylabel('y[n]');
legend('Linear - h2', 'OVA - h2');
grid on;
figure;
plot(L,timeOVAconv1,'o-',L,timeOVAconv2,'o-');
title('Runing time VS. frame size')
xlabel('Frame size')
ylabel('Runing time')
legend('OVA runing time h1','OVA runing time h2')
grid on;
%done
%% Q1- writing FFT and IFFT and comparing to the built in function.
t=linspace(0,10,128);
fs=1/t(2)-t(1);
exmp = cos(2*pi*t);
% Creating the freq axis, as we learned in class we have a change in the
% freq axis in the grapic represantaion, so we create it.
freq=(0:length(exmp)-1)*fs/length(exmp);
% Perform FFT using our function
X_FFT = custom_fft(exmp);
figure;
subplot(2,2,1)
% Display the result
% Perform FFT using built-in function
plot(freq, abs(fft(exmp)))
title('X- Built in fft of x[n]')
xlabel('frequencies')
ylabel('|X|')
subplot(2,2,3)
plot(freq,abs(X_FFT),'r')
title('X- Our function for fft of x[n]')
xlabel('frequencies')
ylabel('|X|')
% Perform IFFT using our function
x_new = custom_ifft(X_FFT);
subplot(2,2,2)
% Perform IFFT using built-in function
plot(t,ifft(X_FFT))
title('x- built in function for ifft of X[k]')
xlabel('time')
ylabel('signal')
subplot(2,2,4)
plot(t,x_new,'r')
title('x- our function for ifft of X[k]')
xlabel('time')
ylabel('signal')
%done


function x = custom_ifft(X)
    % Ensure X is a column vector
    X = X(:); 
    % Get the number of points
    N = length(X);
    % Check if N is a power of 2, for the optimization of the Cooley-Tukey
    % FFT algorithm.
    if mod(log2(N), 1) ~= 0
        n = nextpow2(N);
        closest_pow_of_2 = 2^n;
        X = [X; zeros( closest_pow_of_2 -N,1)];
    end
    N = length(X);
    % Conjugate the input
    X = conj(X);
    % Perform the FFT on the conjugated input
    X = custom_fft(X);
    % Conjugate the result and scale by 1/N, the full mathematical
    % explanation for why it works is in the PDF.
    x = conj(X) / N;
end

function X = custom_fft(x)
    % Ensure x is a column vector
    x = x(:);
    % Get the number of points
    n=length(x);
    N = length(x);
    % Check if N is a power of 2
    if mod(log2(N), 1) ~= 0
       n_upper = nextpow2(N);
        closest_power_of_2 = 2^n_upper;
        x = [x; zeros( closest_power_of_2 -N,1)]; 
    end
    N = length(x);
    % Bit-reversal permutation
    n = 0:N-1;
    j = bitrevorder(n);
    % Reorder the input array
    x=x(j+1);
    % Initialize the FFT output
    X=x;
    % Iterative Cooley-Tukey FFT
    for s=1:log2(N)
        m=2^s;
        m2=m/2;
        w = exp(-2i * pi / m);
        for k = 0:m:(N-1)
            for j = 0:(m2-1)
                t = w^j*X(k+j+m2+1);
                u = X(k+j+1);
                X(k+j+1)= u+t;
                X(k+j+m2+1) = u - t;
            end
        end
    end
end

%conv function- Q3-C 
function y = manual_conv(x, h)
    x_l=length(x);
    h_l=length(h);
    % As we learned the size of the conv is the sum of the 2 signals -1.
    y = zeros(1, h_l+x_l-1);
    for n = 1:length(y)
        for k = 1:h_l
            % For each itr we need to check if the value is within the
            % range for x, normally we would do n-k, because the sum would
            % start from 0, but it is MATLAB so +1 it is.
            if (n-k+1>0) && (n-k+1<=x_l)
                % Summing the products and adding to y in the correct ind.
                y(n) = y(n)+x(n-k+1)*h(k);
            end
        end
    end
end
% done

% OVA convolution function-Q3-D
% the general frame suze will be: Nh + L -1.
% we want to check diffrence sizes of L to check witch frame will give us
% the best results, regarding time. 
function y= ova_conv(x,h,L)
    frame_size=2^nextpow2(L+length(h)+1);
    % In order to mult H*X we want to make sure theyre the same frame size so we
    % add padding to H.
    h_new=[h,zeros(1,frame_size-length(h))];
    H=custom_fft(h_new);
    % Checking how many frames we have.
    nof=ceil(length(x)/L);
    y=zeros(1,length(x)+length(h)-1);
    for i=1:nof
        curr_seg=x((i-1)*L + 1 : min(length(x),i*L));%extract the curr segment from x
        Curr_Seg=custom_fft([curr_seg,zeros(1,frame_size-length(curr_seg))]);%fft on the seg
        Y_seg=Curr_Seg.*H;%convolution
        y_seg=custom_ifft(Y_seg);%ifft on y
        % Checking edge case for the end of y.
        str_ind=(i-1)*L+1;
        min_y=min(str_ind+frame_size-1,length(y));
        % We do overlap in order to avoid circ conv
        y(str_ind:min_y)=y(str_ind:min_y)+y_seg(1:min(frame_size,min_y-str_ind+1))';%coneecting the segments
    end
end 
%done
