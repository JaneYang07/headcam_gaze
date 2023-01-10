clear;

%raw_data = csvread('child_dom_by_roi_target_exp12.csv', 4); 
raw_data = csvread('joint_largest_by_roi_target_exp12.csv', 4); 

child_roi_col = 40; % joint attend column  
parent_roi_col = 14;
obj_size_child_col =20; 
obj_size_parent_col = 24;
child_inhand_col = 28;
parent_inhand_col = 34; 
%joint_attend_col = 36;


% event selection based on duration 
dur = raw_data(:,4)-raw_data(:,3);

% divided into long (1-3)and short (0.5-1)
low_dur = 0.5;
high_dur = 5;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 

% select a subset based on target object size in both views
obj_size_child = 0.04;
obj_size_parent = 0.02; 
index = intersect(find(data(:,obj_size_child_col)>=obj_size_child),find(data(:,obj_size_parent_col)>=obj_size_parent)); 
data = data(index,:); 



% result
figure(1)
subplot(3,1,1);
histogram(data(:,child_roi_col),'Normalization','probability');
subplot(3,1,2);
histogram(data(:,obj_size_child_col),'Normalization','probability');
%histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normalization','probability');

% divide into visual size, and compare roi during holding 
dom_size = 0.10; 
index = find (data(:,obj_size_child_col)>dom_size);
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



%%% BAR GRAPH

%% VISUAL SIZE vs. ROI DURING HOLDING
figure(4);
index_dom_zero = find(data(index,child_roi_col)==0);
index_dom_between = find(data(index,child_roi_col)<1 & data(index,child_roi_col)>0);
index_dom_one = find(data(index,child_roi_col)==1);
dom_size = size(data(index,child_roi_col),1);

index_no_dom_zero = find(data(setdiff(1:size(data,1),index),child_roi_col)==0);
index_no_dom_between = find(data(setdiff(1:size(data,1),index),child_roi_col)<1 & data(setdiff([1:size(data,1)],index),child_roi_col)>0);
index_no_dom_one = find(data(setdiff(1:size(data,1),index),child_roi_col)==1);
no_dom_size = size(data(setdiff(1:size(data,1),index),child_roi_col),1);

x = categorical({'0','0-1','1'});
x = reordercats(x,{'0','0-1','1'});
y_dom = [size(index_dom_zero,1)/dom_size,size(index_dom_between,1)/dom_size,size(index_dom_one,1)/dom_size];
y_no_dom = [size(index_no_dom_zero,1)/no_dom_size,size(index_no_dom_between,1)/no_dom_size,size(index_no_dom_one,1)/no_dom_size];
y = [y_dom;y_no_dom];

subplot(1,1,1);
h=bar(x,y);

xtips1 = h(1).XEndPoints;
xtips2 = h(2).XEndPoints;
ytips1 = h(1).YEndPoints;
ytips2 = h(2).YEndPoints;
labels1 = string(h(1).YData);
labels2 = string(h(2).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom');
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom');


title('Effect of Visual Size on Attention')
xlabel('ROI Value')
ylabel('Proportion')

legend_labels = {'dominant object','not dominant object'};
legend(legend_labels);


%% CONDITION ON CHILD HOLD vs. PARENT HOLD
inhand_time = 0.5; 
index1 = find(data(:,child_inhand_col)>inhand_time);
index2 = find(data(:,parent_inhand_col)>inhand_time);
both_inhand = intersect(index1,index2);
child_only = setdiff(index1,both_inhand); 
parent_only = setdiff(index2,both_inhand); 
index3=setdiff(1:size(data,1),parent_only);
no_inhand= setdiff(index3,child_only);

figure(5);

index_both_inhand_zero = find(data(both_inhand,child_roi_col)==0);
index_both_inhand_between = find(data(both_inhand,child_roi_col)>0 & data(both_inhand,child_roi_col)<1);
index_both_inhand_one = find(data(both_inhand,child_roi_col)==1);

index_child_only_zero = find(data(child_only,child_roi_col)==0);
index_child_only_between = find(data(child_only,child_roi_col)>0 & data(child_only,child_roi_col)<1);
index_child_only_one = find(data(child_only,child_roi_col)==1);

index_parent_only_zero = find(data(parent_only,child_roi_col)==0);
index_parent_only_between = find(data(parent_only,child_roi_col)>0 & data(parent_only,child_roi_col)<1);
index_parent_only_one = find(data(parent_only,child_roi_col)==1);

index_no_inhand_zero = find(data(no_inhand,child_roi_col)==0);
index_no_inhand_between = find(data(no_inhand,child_roi_col)>0 & data(no_inhand,child_roi_col)<1);
index_no_inhand_one = find(data(no_inhand,child_roi_col)==1);


both_inhand_size = size(data(both_inhand,child_roi_col),1);
child_only_size = size(data(child_only,child_roi_col),1);
parent_only_size = size(data(parent_only,child_roi_col),1);
no_inhand_size = size(data(no_inhand,child_roi_col),1);

y_both_inhand = [size(index_both_inhand_zero,1)/both_inhand_size,size(index_both_inhand_between,1)/both_inhand_size,size(index_both_inhand_one,1)/both_inhand_size];
y_child_only = [size(index_child_only_zero,1)/child_only_size,size(index_child_only_between,1)/child_only_size,size(index_child_only_one,1)/child_only_size];
y_parent_only = [size(index_parent_only_zero,1)/parent_only_size,size(index_parent_only_between,1)/parent_only_size,size(index_parent_only_one,1)/parent_only_size];
y_no_inhand = [size(index_no_inhand_zero,1)/no_inhand_size,size(index_no_inhand_between,1)/no_inhand_size,size(index_no_inhand_one,1)/no_inhand_size];

y_hand = [y_both_inhand;y_child_only;y_parent_only;y_no_inhand];

subplot(1,1,1);
h_hand=bar(x,y_hand);

xtips1_hand = h_hand(1).XEndPoints;
xtips2_hand = h_hand(2).XEndPoints;
xtips3_hand = h_hand(3).XEndPoints;
xtips4_hand = h_hand(4).XEndPoints;
ytips1_hand = h_hand(1).YEndPoints;
ytips2_hand = h_hand(2).YEndPoints;
ytips3_hand = h_hand(3).YEndPoints;
ytips4_hand = h_hand(4).YEndPoints;
labels1_hand = string(h_hand(1).YData);
labels2_hand = string(h_hand(2).YData);
labels3_hand = string(h_hand(3).YData);
labels4_hand = string(h_hand(4).YData);
text(xtips1_hand,ytips1_hand,labels1_hand,'HorizontalAlignment','center','VerticalAlignment','bottom');
text(xtips2_hand,ytips2_hand,labels2_hand,'HorizontalAlignment','center','VerticalAlignment','bottom');
text(xtips3_hand,ytips3_hand,labels3_hand,'HorizontalAlignment','center','VerticalAlignment','bottom');
text(xtips4_hand,ytips4_hand,labels4_hand,'HorizontalAlignment','center','VerticalAlignment','bottom');


title('Effects of Holding on Attention')
xlabel('ROI Value')
ylabel('Proportion')

legend_labels_hand = {'both inhand','child only','parent only','no inhand'};
legend(legend_labels_hand);
