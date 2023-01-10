clear;

raw_data = csvread('dom-joint-inhand_by_roi_target_exp12.csv', 4); 

child_roi_col = 8; 
parent_roi_col = 14;

% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = 0;
high_dur = 1;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% result
subplot(3,1,1);
histogram(data(:,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(:,parent_roi_col),'Normalization','probability');
