%%Exercise 4
%The script assumes that we already ran ECG exercises 1 and 2

%%Task I - HR calculations
MinPeakHeight = 3;
MinPeakDistance = 0.1;
[R_pks_n, R_locs_n] = findpeaks(filtered_n, 'MinPeakHeight',MinPeakHeight, 'MinPeakDistance', MinPeakDistance);
[R_pks_af, R_locs_af] = findpeaks(filtered_af, 'MinPeakHeight',MinPeakHeight, 'MinPeakDistance', MinPeakDistance);

R_locs_n = R_locs_n/fs;
R_locs_af = R_locs_af/fs;

figure(1)
subplot(2, 1, 1)
plot(time, filtered_n);
hold on
plot(R_locs_n, R_pks_n, 'ro')
title('Normal data peak detection');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

subplot(2, 1, 2)
plot(time, filtered_af);
hold on
plot(R_locs_af, R_pks_af, 'ro')
title('AF data after peak detection');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

length_HR_n = length(R_locs_n);
delta_t_n = zeros(length_HR_n-1, 1);
for k=1:(length_HR_n-1)
    delta_t_n(k) = R_locs_n(k+1)-R_locs_n(k);
end
HR_n = 60/mean(delta_t_n)

length_HR_af = length(R_locs_af);
delta_t_af = zeros(length_HR_af-1, 1);
for k=1:(length_HR_af-1)
    delta_t_af(k) = R_locs_af(k+1)-R_locs_af(k);
end
HR_af = 60/mean(delta_t_af)

%%Task II - HRV calculations

delta_t_n_ms = delta_t_n*1000;
delta_t_af_ms = delta_t_af*1000;
t_n = R_locs_n(2:(length_HR_n));
t_af = R_locs_af(2:(length_HR_af));

figure(1)
subplot(2, 2, 1)
plot(time, filtered_n);
hold on
plot(R_locs_n, R_pks_n, 'ro')
title('Normal data peak detection');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

subplot(2, 2, 2)
plot(time, filtered_af);
hold on
plot(R_locs_af, R_pks_af, 'ro')
title('AF data after peak detection');
xlabel('Time[s]')
ylabel('Amplitude [no unit]')

subplot(2, 2, 3)
plot(t_n, delta_t_n_ms, '--ok');
title('R-R Intervals (Normal)')
xlabel('Time[s]')
ylabel('R-R Interval [ms]')
axis([0 30 600 1200])

subplot(2, 2, 4)
plot(t_af, delta_t_af_ms, '--ok');
title('R-R Intervals (AF)')
xlabel('Time[s]')
ylabel('R-R Interval [ms]')

figure(2)
subplot(1, 2, 1)
histogram(delta_t_n_ms, 'BinWidth', 20)
axis([0 1200 0 10.5])
title('Distribution of RR-intervals for Normal Data')
ylabel('Count')
xlabel('R-R Interval [ms]')

subplot(1, 2, 2)
histogram(delta_t_af_ms, 'BinWidth', 20)
axis([0 1200 0 10.5])
title('Distribution of RR-intervals for AF Data')
ylabel('Count')
xlabel('R-R Interval [ms]')

%%Lomb-Scargle PSD RR-Interval Spectrum
delta_t_n = delta_t_n - mean(delta_t_n);
delta_t_af = delta_t_af - mean(delta_t_af);

f_interest = 0.001:0.001:0.6;

[pxxL_n, fL_n] = plomb(delta_t_n, t_n, f_interest, 'psd');
[pxxL_af, fL_af] = plomb(delta_t_af, t_af, f_interest, 'psd');

figure(3)
subplot(2, 1, 1)
plot(fL_n, pxxL_n);
xlabel('Frequency (Hz)')
ylabel('PSD (s^{2}Hz^{-1})')
title('Lomb-Scargle PSD Spectrum for Normal Data')

subplot(2, 1, 2)
plot(fL_af, pxxL_af);
xlabel('Frequency (Hz)')
ylabel('PSD (s^{2}Hz^{-1})')
title('Lomb-Scargle PSD Spectrum for AF Data')