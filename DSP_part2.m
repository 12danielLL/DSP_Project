Y=fft(y);
Z=fft(z);

Hy=abs(Y).^2;
Hz=abs(Z).^2;

freq=(1:length(Y))*Fs/length(Y);
figure;
subplot(2,1,1);
plot(freq,Hy);
title(' DFT of Y');
xlabel('frequencis');
ylabel('|Y|^2');
subplot(2,1,2);
plot(freq,Hz);
title(' DFT of Z');
xlabel('frequencis');
ylabel('|Z|^2');

playerObj_y = audioplayer(y, Fs);
start = 1;
stop = playerObj_y.SampleRate * 3;
play(playerObj_y, [start stop]);

playerObj_z = audioplayer(z, Fs);
play(playerObj_z, [start stop]);


L=length(Y);
T=2;

A_s=20;
A_p=5;
Omega_s=3600*2*pi/2;
Omega_p=3800*2*pi;

delta_s=10^(-20/A_s);
delta_p=1-10^(-A_p/A_s);

w_s=Omega_s/Fs;
w_p=Omega_p/Fs;

Omega_pt=(2/T)*tan(Omega_p/2);
Omega_st=(2/T)*tan(Omega_s/2);

d=sqrt(((1-delta_p)^(-2)-1)/(delta_s^(-2)-1));
kappa=Omega_pt/Omega_st;
N=ceil(log(1/d)/log(1/kappa));

omega_min=Omega_pt*(((1-delta_p)^(-2)-1)^(-1/2*N));
omega_max=Omega_st*(((delta_s)^(-2)-1)^(-1/2*N));
Omega0=(omega_max+omega_min)/2;


% Butterworth IIR analog
k=0:1:N-1;
s_k = Omega0.* exp(1j * (N+1+2*k)*pi/(2*N));

H_b = 1;
s = linspace(0, 2*Omega_s, L); % freq vector
for k = 0 : N-1
    H_b = H_b .* ((-s_k(k+1)) ./ (1j.*s - s_k(k+1)));
end
plot(s, mag2db(abs(H_b)));
title("Butterworth Filter Frequency Response");
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
grid on

% we have studied that the filters H(s) and H(jOmega) are identical
% we will show both of them 

omega_tag=linspace(0,2*Omega_s,L);

Hbw_j= 1 ./ (1 + (omega_tag / Omega_0).^(2*N));
plot(omega_tag, mag2db(abs(Hbw_j)))
title('Butterworth Filter H^2(\omega) Response')
xlabel('Frequency \omega (rad/s)')
ylabel('H^2(\omega)')
grid on

ֵ%Calculating the digital filter using bilinear H(e^jw) 

omega=linspace(0,2*pi,L);
z=exp(1j.*omega);
s2=(2/T)*(z-1)./(z+1);

Hejw=1;
for k=0:N-1
    Hejw = Hejw .* ((s_k(k+1)) ./ (s2 - s_k(k+1)));
end

plot(omega, mag2db(abs(Hejw)));
xlabel('Frequency (rad/sec)', 'Interpreter','latex');
ylabel('dB', 'Interpreter','latex');
title("Magnitune of the DIGITAL filter", 'Interpreter','latex');
xlim([0,pi]);

%Hc(j*Omega)
omega_real=omega*Fs;

plot(omega_real, mag2db(abs(Hejw)));
xlabel('Frequency (rad/sec)', 'Interpreter','latex');
ylabel('dB', 'Interpreter','latex');
title("Magnitune of the ANALOG filter", 'Interpreter','latex');
xlim([0,pi]);


%Filtering the signal 
Y_filterd=Y.*Hejw;
y_filterd=ifft(Y_filterd);

% Plot freq transfer function 
plot(f, mag2db(abs(y_filterd).^2));
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('dB', 'Interpreter','latex');
title("$Z^2$ - FILTERED in FREQ domain",'Interpreter','latex');
xlim([0, Fs]);


playerObj = audioplayer(y_filterd,Fs);
start = 1;
stop = playerObj.SampleRate * 3;
play(playerObj,[start,stop]);


























