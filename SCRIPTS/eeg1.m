%%Exercise 1 of Section B - EEG

Name1 = 'EEGeyesclosed.mat';
Name2 = 'EEGeyesopen.mat';
Location = '/Users/isidoraradenkovic/Desktop/Education/B18/Lab/B18-Wearables-Laboratory-main/DATA/B18_EEG_data';
Complete1 = fullfile(Location, Name1);
Complete2 = fullfile(Location, Name2);
load(Complete1);
load(Complete2);

fs = 256;
range = 1:1:512;
time_range = (range-1)./fs;

figure(1)
subplot(2, 1, 1)
plot(time_range, eyesopen(range))
xlabel('Time (s)')
ylabel('Amplitude (\muV)')
title('Eyes open, RAW data')
subplot(2, 1, 2)
plot(time_range, eyesclosed(range))
xlabel('Time (s)')
ylabel('Amplitude (\muV)')
title('Eyes closed, RAW data')

fc = 30;
Wn = fc/fs;
norder = 4;

mean_open = mean(eyesopen);
std_open = sqrt(sum((eyesopen - mean_open).^2)/(length(eyesopen)-1));
eyesopen = (eyesopen-mean_open)/std_open;

mean_closed = mean(eyesclosed);
std_closed = sqrt(sum((eyesclosed - mean_closed).^2)/(length(eyesclosed)-1));
eyesclosed = (eyesclosed-mean_closed)/std_closed;

[B, A] = butter(norder, Wn);
signal_open = filter(B, A, eyesopen);
signal_closed = filter(B, A, eyesclosed);

figure(2)
subplot(2, 1, 1)
plot(time_range, signal_open(range))
xlabel('Time (s)')
ylabel('Amplitude (\muV)')
title('Eyes open, Processed data')

subplot(2, 1, 2)
plot(time_range, signal_closed(range))
xlabel('Time (s)')
ylabel('Amplitude (\muV)')
title('Eyes closed, Processed data')

%%Modified Periodogram
window_open = hamming(length(signal_open));
window_closed = hamming(length(signal_closed));

f_low = 60;

[pxx_open, f_open] = periodogram(signal_open, window_open, [], fs, 'psd');
[pxx_closed, f_closed] = periodogram(signal_closed, window_closed, [], fs, 'psd');

figure(3)
subplot(2, 1, 1)
plot(f_open, pxx_open);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title('Modified Periodogram PSD for Open Eyes')

subplot(2, 1, 2)
plot(f_closed, pxx_closed);
xlim([0, f_low])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title('Modified Periodogram PSD for Closed Eyes')