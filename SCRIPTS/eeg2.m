%%Exercise 2

Name = 'EEGSleepStateData.mat';
Location = '/Users/isidoraradenkovic/Desktop/Education/B18/Lab/B18-Wearables-Laboratory-main/DATA/B18_EEG_data';
Complete = fullfile(Location, Name);
load(Complete)

minutes = EEGSleepStateData.minutes;
category = EEGSleepStateData.sleep_category_num;

figure(1)
stairs(minutes, category)
title('Sleep categories vs Time')
xlabel('Time [min]')
ylabel('Sleep Category')
ylim([0.5 4.5])
grid on

category = category - mean(category);
fs = 60;

window = hamming(length(category));
[pxx, f] = periodogram(category, window, [], fs);

figure(2)
plot(f, pxx);
xlim([0, 40])
xlabel('Frequency (Hz)')
ylabel('PSD (mV^{2}Hz^{-1})')
title("Modified Periodogram PSD for the Sleep Categories")

MinPeakHeight = 0.8;
[freq, ~] = findpeaks(pxx, 'MinPeakHeight',MinPeakHeight)