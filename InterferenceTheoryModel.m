function [Direct_linear, Direct_phase, indirect_linear, indirect_phase, Absorption ] = InterferenceTheoryModel(Freq, data_withoutGP, Thickness, EpsilonReal, EpsilonImag)
%% ���������νṹ�������������������ظ���ģ�ͼ���˵��
% Author: cuizijian_harbin@163.com
% Data: 20240520����
% ����ʹ�ã�������������ף�[10.1002/pssa.201800940] [10.1364/OE.20.007165]
% ���                               % Return
% Direct_linear: linearֱ�ӷ���      % Linear direct reflection
% Direct_phase: ֱ�ӷ�����λ         % Phase of direct reflection
% indirect_linear: linear��ӷ���    % Linear indirect reflection
% indirect_phase: ��ӷ�����λ       % Phase of indirect reflection
% Absorption: ���չ���               % Calculated absorption spectrum

% ����                                                  % Input
% Freq: Ƶ��                                            % Frequency
% data_withoutGP: �޳ĵ׷����õķ���ϵ����͸��ϵ��
% ��r12,t12,t21,r21˳������                             % [r12,t12,t21,r21]
% ��ӦS����˳��Ϊ: S11/S21/S12/S22��                    % [S11,S21,S12,S22]
% Thickness: ���ʲ��� (m)             % Thickness of the spacer
% EpsilonReal: ���ʲ��糣��ʵ��   % Real part of the permittivity
% EpsilonImag: ���ʲ��糣���鲿   % Imaginary part of the permittivity

%% ���ظ���ģ�ͼ���
%light speed
c = 3e8; 
%thickness of spacer                                                   
d = Thickness;
%dielectric constant.
epsilon = (EpsilonReal + 3 * EpsilonImag * 1i) * 8.85 * 1e-12;    
%complex propagation phase difference.
beta = sqrt(epsilon) * d * 2 * pi * Freq / c;   
r12 = data_withoutGP(:,1);
t12 = data_withoutGP(:,2);
t21 = data_withoutGP(:,3);
r21 = data_withoutGP(:,4);

% cal 4 indirect
Indirect = (t12.*t21)./(r21+exp(-2i*beta));   
% ABS
indirect_linear = abs(Indirect);
Direct_linear = abs(r12);
% Phase
indirect_phase = (unwrap(angle(-Indirect),1.5*pi)); 
Direct_phase = (unwrap(angle(r12),1.5*pi));
% Final result
FinalPre = r12-Indirect;
Absorption = 1 -abs(FinalPre).^2;
end