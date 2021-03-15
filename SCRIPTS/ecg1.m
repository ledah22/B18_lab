%%Exercise 1 of Section A - ECG
Name = 'PhysionetData.mat';
Location = '/Users/isidoraradenkovic/Desktop/Education/B18/Lab/B18-Wearables-Laboratory-main/DATA/B18_ECG_data';
Complete = fullfile(Location, Name);
load(Complete);

normal_data = cell2mat(Signals(9));
normal_data1 = cell2mat(Signals(450));    %A04645, 450
af_data = cell2mat(Signals(1009));
af_data1 = cell2mat(Signals(864));       %A01693, 864
other_data = cell2mat(Signals(1050));
noisy_data = cell2mat(Signals(4181));

fs = 300;
range = 200:1:2000;
time_range = range ./fs;

figure(1)
plot(time_range, normal_data(range))
text(507/fs, 165, "P");
text(575/fs, -135, "Q");
text(585/fs, 805, "R");
text(600/fs, -90, "S");
text(665/fs, 252, "T");
axis([time_range(1) time_range(length(time_range)) -400 1000])
title('Characteristic points observed on a healthy person')
xlabel('Time[s]')
ylabel('Amplitude [mV]')


time = (1:1:length(normal_data))./fs;

figure(2)

subplot(4, 1, 1);
plot(time, normal_data);
title('Normal Data, Recording 9')
xlabel('Time[s]')
ylabel('Amplitude [mV]')

subplot(4, 1, 2);
plot(time, af_data);
title('AF Data, Recording 1009')
xlabel('Time[s]')
ylabel('Amplitude [mV]')

subplot(4, 1, 3);
plot(time, other_data);
title('Other Data, Recording 1050')
xlabel('Time[s]')
ylabel('Amplitude [mV]')

subplot(4, 1, 4);
plot(time, noisy_data);
title('Noisy Data, Recording 4181')
xlabel('Time[s]')
ylabel('Amplitude [mV]')


