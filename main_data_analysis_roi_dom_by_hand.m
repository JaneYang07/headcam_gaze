clear;

raw_data = csvread('roi-dom-match-by-inhand_target_exp12.csv', 4); 
raw_data = csvread('dom-mismatch-roi-by-inhand_target_exp12.csv', 4); 
raw_data = csvread('roi-wo-dom-by-inhand_target_exp12.csv', 4); 

child_inhand_col = 8; 
parent_inhand_col = 14;

% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = .5;
high_dur = 1;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% reduce inhand to be 1 
index = find(data(:,child_inhand_col)>1);
data(index,child_inhand_col) = 1;
index = find(data(:,parent_inhand_col)>1);
data(index,parent_inhand_col) = 1;


% result
subplot(3,1,1);
histogram(data(:,child_inhand_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(:,parent_inhand_col),'Normalization','probability');
subplot(3,1,3);
histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normalization','probability');