%%Exercise 2
%Task 1
%The script assumes that we already ran Exercise 1

mean_n = mean(normal_data);
mean_af = mean(af_data);

N_n = length(normal_data);
N_af = length(af_data);

std_n = sqrt(sum((normal_data - mean_n).^2)/(N_n-1));
std_af = sqrt(sum((af_data - mean_af).^2)/(N_af-1));

detrend_n = normal_data - mean_n;
detrend_af = af_data - mean_af;

figure(1)
subplot(2, 1, 1)
plot(time, detrend_n);
xlabel('Time[s]')
ylabel('Amplitude [mV]')
title('Detrended normal data')

subplot(2, 1, 2)
plot(time, detrend_af);
xlabel('Time[s]')
ylabel('Amplitude [mV]')
title('Detrended AF data')


z_n = detrend_n/std_n;
z_af = detrend_af/std_af;

figure(2)
subplot(2, 1, 1)
plot(time, z_n);
title('Z-score for normal data');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

subplot(2, 1, 2)
plot(time, z_af);
title('Z-score for AF data');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

%%Task 2
f_high = 0.5;
f_low = 40;
norder = 4;

filtered_n = filter_ecg(z_n, fs, f_high, f_low, norder);
filtered_af = filter_ecg(z_af, fs, f_high, f_low, norder);

figure(3)
subplot(2, 1, 1)
plot(time, filtered_n);
title('Normal data after filtering');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

subplot(2, 1, 2)
plot(time, filtered_af);
title('AF data after filtering');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

