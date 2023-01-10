clear;

%raw_data = csvread('child_dom_by_roi_target_exp12.csv', 4); 
raw_data = csvread('joint_attend_by_roi_target_exp12_v2.csv', 4); 

child_roi_col = 8;   
parent_roi_col = 14;
child_obj_size_col =20; 
parent_obj_size_col = 24;
child_inhand_col = 28;
parent_inhand_col = 34; 
joint_attend_col = 40;
child_largest_col = 58;
parent_largest_col =64; 


% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = 1;
high_dur = 10;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% select a subset based on target object size in both views
%obj_size_child = 0.04;
%obj_size_parent = 0.02; 
%index = intersect(find(data(:,obj_size_child_col)>=obj_size_child),find(data(:,obj_size_parent_col)>=obj_size_parent)); 
%data = data(index,:); 
inhand_time = 0.5;
large_time = 0.2; 
index1 = find(data(:,child_inhand_col)>inhand_time);
index2 = find(data(:,child_largest_col)>large_time);
index3 = find(data(:,parent_inhand_col)>inhand_time);
index4 = find(data(:,parent_largest_col)>large_time);
child_inhand_large = intersect(index1,index4);
% child_inhand_large = intersect(intersect(index1,index4),index4);
% parent_inhand_large = intersect(intersect(index3,index2),index2);
parent_inhand_large = intersect(index3,index2);
inhand_large = union(child_inhand_large,parent_inhand_large);

length(inhand_large)/size(data,1);




% result
figure(1)
subplot(4,1,1);
histogram(data(:,child_largest_col),'Normalization','probability');
subplot(4,1,2);
histogram(data(:,child_obj_size_col),'Normalization','probability');
% subplot(4,1,3);
% histogram(data(:,joint_attend_col),'Normalization','probability');
% subplot(4,1,4);
% histogram(data(:,joint_attend_col),'Normalization','probability');

subplot(4,1,3);
histogram(data(:,parent_largest_col),'Normalization','probability');
subplot(4,1,4);
histogram(data(:,parent_obj_size_col),'Normalization','probability');
%histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normalization','probability');

% divide baed on prop of time that the held obj is largest within a holding instance
largest_prop = 0.50; 
index = find (data(:,parent_largest_col)>largest_prop);
%index2 = setdiff([1:size(data,1)],index1);

figure(2); 
subplot(6,1,1);
histogram(data(index,child_roi_col),'Normalization','probability');
subplot(6,1,2);
histogram(data(setdiff([1:size(data,1)],index),child_roi_col),'Normalization','probability');
subplot(6,1,3);
histogram(data(index,parent_roi_col),'Normalization','probability');
subplot(6,1,4);
histogram(data(setdiff([1:size(data,1)],index),parent_roi_col),'Normalization','probability');
subplot(6,1,5);
histogram(data(index,joint_attend_col),'Normalization','probability');
subplot(6,1,6);
histogram(data(setdiff([1:size(data,1)],index),joint_attend_col),'Normalization','probability');

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






