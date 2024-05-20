function [Direct_linear, Direct_phase, indirect_linear, indirect_phase, Absorption ] = InterferenceTheoryModel(Freq, data_withoutGP, Thickness, EpsilonReal, EpsilonImag)
%% 金属三明治结构超表面完美吸收器多重干涉模型计算说明
% Author: cuizijian_harbin@163.com
% Data: 20240520整理
% 如需使用，请引用相关文献：[10.1002/pssa.201800940] [10.1364/OE.20.007165]
% 输出                               % Return
% Direct_linear: linear直接反射      % Linear direct reflection
% Direct_phase: 直接反射相位         % Phase of direct reflection
% indirect_linear: linear间接反射    % Linear indirect reflection
% indirect_phase: 间接反射相位       % Phase of indirect reflection
% Absorption: 吸收光谱               % Calculated absorption spectrum

% 输入                                                  % Input
% Freq: 频率                                            % Frequency
% data_withoutGP: 无衬底仿真获得的反射系数与透射系数
% 按r12,t12,t21,r21顺序排列                             % [r12,t12,t21,r21]
% 对应S参数顺序为: S11/S21/S12/S22）                    % [S11,S21,S12,S22]
% Thickness: 介质层厚度 (m)             % Thickness of the spacer
% EpsilonReal: 介质层介电常数实部   % Real part of the permittivity
% EpsilonImag: 介质层介电常数虚部   % Imaginary part of the permittivity

%% 多重干涉模型计算
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