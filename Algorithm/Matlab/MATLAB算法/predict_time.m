function y = predict_time(a1,a2,a3)
%%  导入数据（时间序列的单列数据）
result = xlsread('数据6.xls');

%%  数据分析
num_samples = length(result);  % 样本个数 
kim = 3;                      % 延时步长（kim个历史数据作为自变量）
zim =  1;                      % 跨zim个时间点进行预测

%%  构造数据集
for i = 1: num_samples - kim - zim + 1
    res(i, :) = [reshape(result(i: i + kim - 1), 1, kim), result(i + kim + zim - 1)];
end

%%  划分训练集和测试集
temp = 1: 1: 947;

P_train = res(temp(1: 700), 1: 3)';
T_train = res(temp(1: 700), 4)';
M = size(P_train, 2);

P_test = res(temp(701: end), 1: 3)';
T_test = res(temp(701: end), 4)';
N = size(P_test, 2);

test = [a1 a2 a3]
test2 = [15 a1 a2 a3 30]
%%  数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);
p_test = mapminmax('apply', P_test, ps_input);
size(p_train);
size(p_test);

[t_train, ps_output] = mapminmax(T_train, 0, 1);
t_test = mapminmax('apply', T_test, ps_output);
size(t_train);
size(t_test);

[test1, ps_output1] = mapminmax(test, 0, 1);
[test3, ps_output2] = mapminmax(test2, 0, 1);
%%  转置以适应模型
p_train = p_train'; p_test = p_test';
t_train = t_train'; t_test = t_test';
test1 = test1'
size(test1,2)
%%  创建模型
c = 4.0;    % 惩罚因子
g = 0.8;    % 径向基函数参数
cmd = [' -t 2',' -c ',num2str(c),' -g ',num2str(g),' -s 3 -p 0.01'];
model = svmtrain(t_train, p_train, cmd);

%%  仿真预测
[t_sim1, ~] = svmpredict(zeros(size(test1,1),1),test1,model)

%%  数据反归一化
if a1 == a2 && a2 == a3
    T_sim1 = mapminmax('reverse', t_sim1, ps_output2)
    y = T_sim1(1);
else
    T_sim1 = mapminmax('reverse', t_sim1, ps_output1)
    y = T_sim1(1);
end
end

