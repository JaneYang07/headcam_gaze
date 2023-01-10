clear;

raw_data = csvread('child_inhand_by_roi_target_exp12.csv', 4); 

child_roi_col = 8; 
parent_roi_col = 14;
obj_size_col =20; 

% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = .5;
high_dur = 5;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% result
subplot(3,1,1);
histogram(data(:,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(:,obj_size_col),'Normalization','probability');
%histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normaliz ation','probability');

% divide into visual size, and compare roi during holding 
dom_size = 0.10; 
index = find (data(:,obj_size_col)>dom_size);
figure(2); 
subplot(3,1,1);
histogram(data(index,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(setdiff([1:size(data,1)],index),child_roi_col),'Normalization','probability');



