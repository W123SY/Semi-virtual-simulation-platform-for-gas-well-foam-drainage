clear
da = opcda('localhost','KingView.View.1');
connect(da);
grp1 = addgroup(da,'daR_P');
grp2 = addgroup(da,'daW_P');
grp3 = addgroup(da,'daR_P1');
grp4 = addgroup(da,'daW_P1');
grp5 = addgroup(da,'daR_P2');
grp6 = addgroup(da,'daW_P2');
grp7 = addgroup(da,'daR_P3');
grp8 = addgroup(da,'daW_P3');
count = 0;
count1 = 0;
count2 = 0;
count3 = 0;
input2 = 0;
input6 = 0;
input7 = 0;
input8 = 0;
input10 = 0;
input12 = 0;
model = create_model();
net = create_bpnetmodel();
model1 = create_nolin();
while(true)
itm1 = additem(grp1,{'注药量.Value'});
values1 = read(itm1);
itm2 = additem(grp2,{'产气量.Value'});
values2 = read(itm2);
itm3 = additem(grp3,{'时间1.Value', '时间2.Value', '时间3.Value'});
values3 = read(itm3(1));
values4 = read(itm3(2));
values5 = read(itm3(3));
itm4 = additem(grp4,{'产气1.Value'});
values6 = read(itm4);
itm5 = additem(grp5,{'注药量1.Value'});
values16 = read(itm5);
itm6 = additem(grp6,{'产气量1.Value'});
values17 = read(itm6);
itm7 = additem(grp7,{'注药量2.Value'});
values18 = read(itm7);
itm8 = additem(grp8,{'产气量2.Value'});
values19 = read(itm8);
set(da,'Timeout',30,'EventLogMax',2000);
set(grp1,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp2,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp3,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp4,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp5,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp6,'UpdateRate',1,'RecordsToAcquire',1000,'Active','on','Subscription','on');
set(grp1,'RecordsAcquiredFcn' ,@opccallback);
set(grp3,'RecordsAcquiredFcn' ,@opccallback);
set(grp5,'RecordsAcquiredFcn' ,@opccallback);
%itm1(1).value;
input1 = itm1(1).value;
input3 = itm3(1).value;
input4 = itm3(2).value;
input5 = itm3(3).value;
input9 = itm5(1).value;
input11 = itm7(1).value;
if input2 ~= input1 && count~=0
    Out1 = predict_model(cast(input1,'double'),model);
    writeasync(itm2,Out1);
end
count=count+1;
input2 = input1;
if input10 ~= input9 && count2~=0
    Out3 = net_model(cast(input9,'double'),net);
    writeasync(itm6,Out3);
end
count2=count2+1;
input10 = input9;
if input12 ~= input11 && count3~=0
    Out4 = predict_nolin(cast(input11,'double'),model1);
    writeasync(itm8,Out4);
end
count3=count3+1;
input12 = input11;
if (input6 ~= input3 || input7 ~= input4 || input8 ~= input5) && count1~=0
    Out2 = predict_time(cast(input3,'double'), cast(input4,'double'), cast(input5,'double'));
    writeasync(itm4,Out2)
end
count1=count1+1;
input6 = input3;
input7 = input4;
input8 = input5;
end
