clear;

raw_data = csvread('child_dom_by_roi_target_exp12.csv', 4); 

child_roi_col = 8; 
parent_roi_col = 14;
obj_size_col =20; 
child_inhand_col = 24;
parent_inhand_col = 30; 

% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = 2;
high_dur = 5;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% result
figure(1)
subplot(3,1,1);
histogram(data(:,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(:,obj_size_col),'Normalization','probability');
%histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normalization','probability');

% divide into visual size, and compare roi during holding 
dom_size = 0.10; 
index = find (data(:,obj_size_col)>dom_size);
figure(2); 
subplot(3,1,1);
histogram(data(index,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(setdiff([1:size(data,1)],index),child_roi_col),'Normalization','probability');

% conditioned on child hold and parent hold
figure(3);
inhand_time = 0.5; 
index1 = find(data(:,child_inhand_col)>inhand_time);
index2 = find(data(:,parent_inhand_col)>inhand_time);
both_inhand = intersect(index1,index2);
subplot(4,1,1);
histogram(data(both_inhand,child_roi_col),'Normalization','probability');
subplot(4,1,2);
child_only = setdiff(index1,both_inhand); 
histogram(data(child_only,child_roi_col),'Normalization','probability');
subplot(4,1,3);
parent_only = setdiff(index2,both_inhand); 
histogram(data(parent_only,child_roi_col),'Normalization','probability');
subplot(4,1,4);
index3=setdiff([1:size(data,1)],parent_only);
no_inhand= setdiff(index3,child_only);
histogram(data(no_inhand,child_roi_col),'Normalization','probability');






