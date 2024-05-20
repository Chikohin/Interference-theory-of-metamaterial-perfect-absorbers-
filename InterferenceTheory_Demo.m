data = load('s_linear.txt');
pdata = load('s_phase.txt');
Freq = data(1:1001,1);
s_data = reshape(data(:,2),[1001,4]);
p_data = reshape(pdata(:,2),[1001,4]);

r12=s_data(:,1).*exp(1i*deg2rad(p_data(:,1)));
t12=s_data(:,2).*exp(1i*deg2rad(p_data(:,2)));
t21=s_data(:,3).*exp(1i*deg2rad(p_data(:,3)));
r21=s_data(:,4).*exp(1i*deg2rad(p_data(:,4)));
data_withoutGP = [r12,t12,t21,r21];
Thickness = 10e-6;
EpsilonReal = 3.5;
EpsilonImag = 0;
[Direct_linear, Direct_phase, indirect_linear, indirect_phase, Absorption ] = InterferenceTheoryModel(Freq, data_withoutGP, Thickness, EpsilonReal, EpsilonImag);

plot(Freq,Absorption)
hold on
plot(Freq,Direct_linear)
plot(Freq,indirect_linear)
legend('Absorption','Direct','Indirect')