function model = create_model(~)
%%  导入数据
res = xlsread('数据4.xls');
%res1 = res(:,1);

%%  划分训练集和测试集
temp = randperm(247);

P_train = res(temp(1: 180), 1)';
T_train = res(temp(1: 180), 2)';
M = size(P_train, 2);

P_test = res(temp(181: end), 1)';
T_test = res(temp(181: end), 2)';
%{
T_test1 = res(temp(181: end), 2);
in_test1 = [T_test1;in_test]';
N = size(P_test, 2);
%}
%%  数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);
p_test = mapminmax('apply', P_test, ps_input);

[t_train, ps_output] = mapminmax(T_train, 0, 1);
t_test = mapminmax('apply', T_test, ps_output);
%in_test2 = mapminmax('apply', in_test1, ps_output);
%%  转置以适应模型
p_train = p_train'; p_test = p_test';
t_train = t_train'; t_test = t_test';
%in_test2 = in_test2';
%%  创建模型
% 寻找最佳c参数/g参数——交叉验证方法
% SVM模型有两个非常重要的参数C与gamma。
% 其中 C是惩罚系数，即对误差的宽容度。
% c越高，说明越不能容忍出现误差,容易过拟合。C越小，容易欠拟合。C过大或过小，泛化能力变差
% gamma是选择RBF函数作为kernel后，该函数自带的一个参数。隐含地决定了数据映射到新的特征空间后的分布，
% gamma越大，支持向量越少，gamma值越小，支持向量越多。支持向量的个数影响训练与预测的速度。
[c,g] = meshgrid(-10:0.5:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 0;
bestg = 0;
error = Inf;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j) ),' -s 3 -p 0.1'];
        cg(i,j) = svmtrain(t_train,p_train,cmd);
        if cg(i,j) < error
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
        if abs(cg(i,j) - error) <= eps && bestc > 2^c(i,j)
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
model = svmtrain(t_train, p_train, cmd);
end