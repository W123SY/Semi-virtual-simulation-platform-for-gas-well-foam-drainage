function y=predict_model(in_test,model)
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

T_test1 = res(temp(181: end), 2);
in_test1 = [T_test1;in_test]';
N = size(P_test, 2);

%%  数据归一化

[p_train, ps_input] = mapminmax(P_train, 0, 1);
p_test = mapminmax('apply', P_test, ps_input);

[t_train, ps_output] = mapminmax(T_train, 0, 1);
t_test = mapminmax('apply', T_test, ps_output);
in_test2 = mapminmax('apply', in_test1, ps_output);
%%  转置以适应模型
%{
p_train = p_train'; p_test = p_test';
t_train = t_train'; t_test = t_test';
%}
in_test2 = in_test2';

[y1, error_3] = svmpredict(zeros(size(in_test2,1),1) , in_test2 , model);
%y2 = max(y1, 0)
%%  数据反归一化
y3 = mapminmax('reverse', y1, ps_output);
y = y3(68)
%%  均方根误差
%error1 = sqrt(sum((T_sim1' - T_train).^2) ./ M)
%error2 = sqrt(sum((T_sim2' - T_test ).^2) ./ N)

%%  绘图
%{
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值','预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid

figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('真实值','预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比';['RMSE=' num2str(error2)]};
title(string)
xlim([1, N])
grid
%}
%%  相关指标计算
%{
%  R2
R1 = 1 - norm(T_train - T_sim1')^2 / norm(T_train - mean(T_train))^2;
R2 = 1 - norm(T_test -  T_sim2')^2 / norm(T_test -  mean(T_test ))^2;

disp(['训练集数据的R2为：', num2str(R1)])
disp(['测试集数据的R2为：', num2str(R2)])

%  MAE
mae1 = sum(abs(T_sim1' - T_train)) ./ M ;
mae2 = sum(abs(T_sim2' - T_test )) ./ N ;

disp(['训练集数据的MAE为：', num2str(mae1)])
disp(['测试集数据的MAE为：', num2str(mae2)])

%  MBE
mbe1 = sum(T_sim1' - T_train) ./ M ;
mbe2 = sum(T_sim2' - T_test ) ./ N ;

disp(['训练集数据的MBE为：', num2str(mbe1)])
disp(['测试集数据的MBE为：', num2str(mbe2)])
%}