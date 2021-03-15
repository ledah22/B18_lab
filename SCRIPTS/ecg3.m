%%Exercise 3
%The script assumes that we already ran previous ECG exercises

%%Task1 - modified periodogram PSD
window_n = hamming(length(filtered_n));
window_af = hamming(length(filtered_af));

[pxx_n, f_n] = periodogram(filtered_n, window_n, [], fs, 'psd');
[pxx_af, f_af] = periodogram(filtered_af, window_af, [], fs, 'psd');

figure(1)
subplot(2, 1, 1)
plot(f_n, pxx_n);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title('Modified Periodogram PSD for Normal Data')

subplot(2, 1, 2)
plot(f_af, pxx_af);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title('Modified Periodogram PSD for AF Signal')

%%Task 2 - Welch's PSD
[pxxW_n, fW_n] = pwelch(filtered_n, [], [], [], fs, 'psd');
[pxxW_af, fW_af] = pwelch(filtered_af, [], [], [], fs, 'psd');

figure(2)
subplot(2, 1, 1)
plot(fW_n, pxxW_n);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title("Welch's PSD estimate for Normal Data")

subplot(2, 1, 2)
plot(fW_af, pxxW_af);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title("Welch's PSD estimate for AF Signal")