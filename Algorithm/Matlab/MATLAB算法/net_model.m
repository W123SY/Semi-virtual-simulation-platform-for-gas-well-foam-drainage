function y = net_model(in_test,net)
%%  导入数据
res = xlsread('数据4.xls');

%%  划分训练集和测试集
temp = randperm(247);
T_test1 = res(temp(181: end), 2);
in_test1 = [T_test1;in_test]';

%%  数据归一化
[in_test2, ps_output1] = mapminmax(in_test1, 0, 1);

y1 = sim(net, in_test2);
y2 = mapminmax('reverse', y1, ps_output1);
y = y2(68)
end

