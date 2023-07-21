function model = create_nolin(~)
%%  导入数据
res = xlsread('数据.xls');
x = res(1:end,1);
y = res(1:end,2);
% 定义非线性模型并进行拟合
fun = @(b,x)(log(x)*b(1)+b(2)); % 模型函数
beta0 = [1 1]; % 初始参数
model = fitnlm(x,y,fun,beta0);
end

