function net = create_bpnetmodel(~)
%%  导入数据
res = xlsread('数据4.xls');

%%  划分训练集和测试集
temp = randperm(247);

P_train = res(temp(1: 180), 1)';
T_train = res(temp(1: 180), 2)';
M = size(P_train, 2);

P_test = res(temp(181: end), 1)';
T_test = res(temp(181: end), 2)';
N = size(P_test, 2);

%%  数据归一化
[p_train, ps_input] = mapminmax(P_train, 0, 1);
p_test = mapminmax('apply', P_test, ps_input);

[t_train, ps_output] = mapminmax(T_train, 0, 1);
t_test = mapminmax('apply', T_test, ps_output);

%%  创建网络
net = newff(p_train, t_train, 5);

%%  设置训练参数
net.trainParam.epochs = 1000;     % 迭代次数 
net.trainParam.goal = 1e-6;       % 误差阈值
net.trainParam.lr = 0.01;         % 学习率

%%  训练网络
net = train(net, p_train, t_train);
end

