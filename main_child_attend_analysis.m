clear;
exp_id = 12;
sub_list = find_subjects({'cont_vision_size_obj9_parent'},[exp_id]);
sub_list = setdiff(sub_list,[1207,1229]);


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

% divided into long (1-3)and short (0.5-1) - only extract the long joint attention events
low_dur = 1;
high_dur = 10;
index = intersect(find(dur>=low_dur),find(dur<=high_dur)); 
data = raw_data(index,:); 


% Hypothesis 2: For child’s attention, both manual action and visual dominance are required to create attention.
% Results needed:
%               P(child's attention | child vis saliency & child inhand) 
%               P(child's attention | no child vis saliency & child inhand)
%               P(child's attention | child vis saliency & parent inhand)
%               P(child's attention | no child vis saliency & parent inhand)
%               P(child's attention | child vis saliency & both inhand) 
%               P(child's attention | no child vis saliency & both inhand)
%               P(child's attention | child vis saliency & no inhand)
%               P(child's attention | no child vis saliency & no inhand)  
obj_size_child = 0.04;
obj_size_parent = 0.02;
inhand_time = 0.5;
index_parent_dom = find(data(:,parent_largest_col)>obj_size_parent);
index_parent_no_dom = setdiff(1:size(data,1),index_parent_dom);
index_child_dom = find(data(:,child_largest_col)>obj_size_child);
index_child_no_dom = setdiff(1:size(data,1),index_child_dom);
index_parent_inhand = find(data(:,parent_inhand_col)>inhand_time);
index_child_inhand = find(data(:,child_inhand_col)>inhand_time);
index_both_inhand = intersect(index_child_inhand,index_parent_inhand);
index_parent_inhand = setdiff(index_parent_inhand,index_both_inhand);
index_child_inhand = setdiff(index_child_inhand,index_both_inhand);
tmp1 = setdiff(1:size(data,1),index_parent_inhand);
tmp2 = setdiff(tmp1,index_child_inhand);
index_no_inhand = setdiff(tmp2,index_both_inhand);

index_c_dom_c_inhand = intersect(index_child_dom,index_child_inhand);
index_c_no_dom_c_inhand = intersect(index_child_no_dom,index_child_inhand);
index_c_dom_p_inhand = intersect(index_child_dom,index_parent_inhand);
index_c_no_dom_p_inhand = intersect(index_child_no_dom,index_parent_inhand);
index_c_dom_both_inhand = intersect(index_child_dom,index_both_inhand);
index_c_no_dom_both_inhand = intersect(index_child_no_dom,index_both_inhand);
index_c_dom_no_inhand = intersect(index_child_dom,index_no_inhand);
index_c_no_dom_no_inhand = intersect(index_child_no_dom,index_no_inhand);

figure(1)
subplot(8,1,1);
histogram(data(index_c_dom_c_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,2);
histogram(data(index_c_no_dom_c_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,3);
histogram(data(index_c_dom_p_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,4);
histogram(data(index_c_no_dom_p_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,5);
histogram(data(index_c_dom_both_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,6);
histogram(data(index_c_no_dom_both_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,7);
histogram(data(index_c_dom_no_inhand,child_roi_col),'Normalization','probability');
subplot(8,1,8);
histogram(data(index_c_no_dom_no_inhand,child_roi_col),'Normalization','probability');

% parent_dom_parent_inhand_mtr = data(index_parent_dom_parent_inhand,parent_roi_col);
% parent_no_dom_parent_inhand_mtr = data(index_parent_no_dom_parent_inhand,parent_roi_col);
% parent_dom_child_inhand_mtr = data(index_parent_dom_child_inhand,parent_roi_col);
% parent_no_dom_child_inhand_mtr = data(index_parent_no_dom_child_inhand,parent_roi_col);
% 
% index_p_dom_p_inhand_zero = find(parent_dom_parent_inhand_mtr==0);
% index_p_dom_p_inhand_between = find(parent_dom_parent_inhand_mtr<1 & parent_dom_parent_inhand_mtr>0);
% index_p_dom_p_inhand_one = find(parent_dom_parent_inhand_mtr==1);
% p_dom_p_inhand_mtr_size = size(parent_dom_parent_inhand_mtr,1);
% 
% index_p_no_dom_p_inhand_zero = find(parent_no_dom_parent_inhand_mtr==0);
% index_p_no_dom_p_inhand_between = find(parent_no_dom_parent_inhand_mtr<1 & parent_no_dom_parent_inhand_mtr>0);
% index_p_no_dom_p_inhand_one = find(parent_no_dom_parent_inhand_mtr==1);
% p_no_dom_p_inhand_mtr_size = size(parent_no_dom_parent_inhand_mtr,1);
% 
% index_p_dom_c_inhand_zero = find(parent_dom_child_inhand_mtr==0);
% index_p_dom_c_inhand_between = find(parent_dom_child_inhand_mtr<1 & parent_dom_child_inhand_mtr>0);
% index_p_dom_c_inhand_one = find(parent_dom_child_inhand_mtr==1);
% p_dom_c_inhand_mtr_size = size(parent_dom_child_inhand_mtr,1);
% 
% index_p_no_dom_c_inhand_zero = find(parent_no_dom_child_inhand_mtr==0);
% index_p_no_dom_c_inhand_between = find(parent_no_dom_child_inhand_mtr<1 & parent_no_dom_child_inhand_mtr>0);
% index_p_no_dom_c_inhand_one = find(parent_no_dom_child_inhand_mtr==1);
% p_no_dom_c_inhand_mtr_size = size(parent_no_dom_child_inhand_mtr,1);
% 


% index_parent_dom_parent_inhand = intersect(index_parent_dom,index_parent_inhand);
% index_parent_no_dom_parent_inhand = intersect(index_parent_no_dom,index_parent_inhand);
% 
% index_parent_dom_child_inhand = intersect(index_parent_dom,index_child_inhand);
% index_parent_no_dom_child_inhand = intersect(index_parent_no_dom,index_child_inhand);
% 
% figure(1)
% subplot(4,1,1);
% histogram(data(index_parent_dom_parent_inhand,parent_roi_col),'Normalization','probability');
% subplot(4,1,2);
% histogram(data(index_parent_no_dom_parent_inhand,parent_roi_col),'Normalization','probability');
% subplot(4,1,3);
% histogram(data(index_parent_dom_child_inhand,parent_roi_col),'Normalization','probability');
% subplot(4,1,4);
% histogram(data(index_parent_no_dom_child_inhand,parent_roi_col),'Normalization','probability');
% 
% figure(2);
% parent_dom_parent_inhand_mtr = data(index_parent_dom_parent_inhand,parent_roi_col);
% parent_no_dom_parent_inhand_mtr = data(index_parent_no_dom_parent_inhand,parent_roi_col);
% parent_dom_child_inhand_mtr = data(index_parent_dom_child_inhand,parent_roi_col);
% parent_no_dom_child_inhand_mtr = data(index_parent_no_dom_child_inhand,parent_roi_col);
% 
% index_p_dom_p_inhand_zero = find(parent_dom_parent_inhand_mtr==0);
% index_p_dom_p_inhand_between = find(parent_dom_parent_inhand_mtr<1 & parent_dom_parent_inhand_mtr>0);
% index_p_dom_p_inhand_one = find(parent_dom_parent_inhand_mtr==1);
% p_dom_p_inhand_mtr_size = size(parent_dom_parent_inhand_mtr,1);
% 
% index_p_no_dom_p_inhand_zero = find(parent_no_dom_parent_inhand_mtr==0);
% index_p_no_dom_p_inhand_between = find(parent_no_dom_parent_inhand_mtr<1 & parent_no_dom_parent_inhand_mtr>0);
% index_p_no_dom_p_inhand_one = find(parent_no_dom_parent_inhand_mtr==1);
% p_no_dom_p_inhand_mtr_size = size(parent_no_dom_parent_inhand_mtr,1);
% 
% index_p_dom_c_inhand_zero = find(parent_dom_child_inhand_mtr==0);
% index_p_dom_c_inhand_between = find(parent_dom_child_inhand_mtr<1 & parent_dom_child_inhand_mtr>0);
% index_p_dom_c_inhand_one = find(parent_dom_child_inhand_mtr==1);
% p_dom_c_inhand_mtr_size = size(parent_dom_child_inhand_mtr,1);
% 
% index_p_no_dom_c_inhand_zero = find(parent_no_dom_child_inhand_mtr==0);
% index_p_no_dom_c_inhand_between = find(parent_no_dom_child_inhand_mtr<1 & parent_no_dom_child_inhand_mtr>0);
% index_p_no_dom_c_inhand_one = find(parent_no_dom_child_inhand_mtr==1);
% p_no_dom_c_inhand_mtr_size = size(parent_no_dom_child_inhand_mtr,1);
% 
% 
% % x = [1 2 3];
% x = [1 2];
% % y_p_dom_p_inhand = [numel(index_p_dom_p_inhand_zero)/p_dom_p_inhand_mtr_size,numel(index_p_dom_p_inhand_between)/p_dom_p_inhand_mtr_size,numel(index_p_dom_p_inhand_one)/p_dom_p_inhand_mtr_size];
% % y_p_no_dom_p_inhand = [numel(index_p_no_dom_p_inhand_zero)/p_no_dom_p_inhand_mtr_size,numel(index_p_no_dom_p_inhand_between)/p_no_dom_p_inhand_mtr_size,numel(index_p_no_dom_p_inhand_one)/p_no_dom_p_inhand_mtr_size];
% % y_p_dom_c_inhand = [numel(index_p_dom_c_inhand_zero)/p_dom_c_inhand_mtr_size,numel(index_p_dom_c_inhand_between)/p_dom_c_inhand_mtr_size,numel(index_p_dom_c_inhand_one)/p_dom_c_inhand_mtr_size];
% % y_p_no_dom_c_inhand = [numel(index_p_no_dom_c_inhand_zero)/p_no_dom_c_inhand_mtr_size,numel(index_p_no_dom_c_inhand_between)/p_no_dom_c_inhand_mtr_size,numel(index_p_no_dom_c_inhand_one)/p_no_dom_c_inhand_mtr_size];
% 
% y_p_dom_p_inhand = [numel(index_p_dom_p_inhand_between)/p_dom_p_inhand_mtr_size,numel(index_p_dom_p_inhand_one)/p_dom_p_inhand_mtr_size];
% y_p_no_dom_p_inhand = [numel(index_p_no_dom_p_inhand_between)/p_no_dom_p_inhand_mtr_size,numel(index_p_no_dom_p_inhand_one)/p_no_dom_p_inhand_mtr_size];
% y_p_dom_c_inhand = [numel(index_p_dom_c_inhand_between)/p_dom_c_inhand_mtr_size,numel(index_p_dom_c_inhand_one)/p_dom_c_inhand_mtr_size];
% y_p_no_dom_c_inhand = [numel(index_p_no_dom_c_inhand_between)/p_no_dom_c_inhand_mtr_size,numel(index_p_no_dom_c_inhand_one)/p_no_dom_c_inhand_mtr_size];
% 
% 
% y = [y_p_dom_p_inhand;y_p_no_dom_p_inhand;y_p_dom_c_inhand;y_p_no_dom_c_inhand];
% 
% subplot(1,1,1);
% 
% h=bar(x,y);
% hold on
% 
% xtips1 = h(1).XEndPoints;
% xtips2 = h(2).XEndPoints;
% xtips3 = h(3).XEndPoints;
% xtips4 = h(4).XEndPoints;
% ytips1 = h(1).YEndPoints;
% ytips2 = h(2).YEndPoints;
% ytips3 = h(3).YEndPoints;
% ytips4 = h(4).YEndPoints;
% labels1 = string(h(1).YData);
% labels2 = string(h(2).YData);
% labels3 = string(h(3).YData);
% labels4 = string(h(4).YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom');
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom');
% text(xtips3,ytips3,labels3,'HorizontalAlignment','center','VerticalAlignment','bottom');
% text(xtips4,ytips4,labels4,'HorizontalAlignment','center','VerticalAlignment','bottom');
% 
% 
% %%% Subject level - plotting individual datapoints
% sub_mean_prop = [];
% 
% [~,~,X] = unique(data(:,1));
% C = accumarray(X,1:size(data,1),[],@(r){data(r,:)});
% % 
% % sanity check counter --> count = numel(index)
% %  count = 0; 
% 
% for i = 1:numel(sub_list)
%     sub_index_parent_dom = find(C{i}(:,parent_largest_col)>obj_size_parent);
%     sub_index_parent_no_dom = setdiff(1:size(C{i},1),index_parent_dom);
%     sub_index_child_dom = find(C{i}(:,child_largest_col)>obj_size_child);
%     sub_index_child_no_dom = setdiff(1:size(C{i},1),index_child_dom);
%     sub_index_parent_inhand = find(C{i}(:,parent_inhand_col)>inhand_time);
%     sub_index_child_inhand = find(C{i}(:,child_inhand_col)>inhand_time);
% 
%     sub_index_parent_dom_parent_inhand = intersect(sub_index_parent_dom,sub_index_parent_inhand);
%     sub_index_parent_no_dom_parent_inhand = intersect(sub_index_parent_no_dom,sub_index_parent_inhand);
%     
%     sub_index_parent_dom_child_inhand = intersect(sub_index_parent_dom,sub_index_child_inhand);
%     sub_index_parent_no_dom_child_inhand = intersect(sub_index_parent_no_dom,sub_index_child_inhand);
% %     count = count + numel(sub_index);
% 
% 
%     sub_parent_dom_parent_inhand_mtr = C{i}(sub_index_parent_dom_parent_inhand,parent_roi_col);
%     sub_parent_no_dom_parent_inhand_mtr = C{i}(sub_index_parent_no_dom_parent_inhand,parent_roi_col);
%     sub_parent_dom_child_inhand_mtr = C{i}(sub_index_parent_dom_child_inhand,parent_roi_col);
%     sub_parent_no_dom_child_inhand_mtr = C{i}(sub_index_parent_no_dom_child_inhand,parent_roi_col);
%     
%     sub_index_p_dom_p_inhand_zero = find(sub_parent_dom_parent_inhand_mtr==0);
%     sub_index_p_dom_p_inhand_between = find(sub_parent_dom_parent_inhand_mtr<1 & sub_parent_dom_parent_inhand_mtr>0);
%     sub_index_p_dom_p_inhand_one = find(sub_parent_dom_parent_inhand_mtr==1);
%     sub_p_dom_p_inhand_mtr_size = size(sub_parent_dom_parent_inhand_mtr,1);
%     
%     sub_index_p_no_dom_p_inhand_zero = find(sub_parent_no_dom_parent_inhand_mtr==0);
%     sub_index_p_no_dom_p_inhand_between = find(sub_parent_no_dom_parent_inhand_mtr<1 & sub_parent_no_dom_parent_inhand_mtr>0);
%     sub_index_p_no_dom_p_inhand_one = find(sub_parent_no_dom_parent_inhand_mtr==1);
%     sub_p_no_dom_p_inhand_mtr_size = size(sub_parent_no_dom_parent_inhand_mtr,1);
%     
%     sub_index_p_dom_c_inhand_zero = find(sub_parent_dom_child_inhand_mtr==0);
%     sub_index_p_dom_c_inhand_between = find(sub_parent_dom_child_inhand_mtr<1 & sub_parent_dom_child_inhand_mtr>0);
%     sub_index_p_dom_c_inhand_one = find(sub_parent_dom_child_inhand_mtr==1);
%     sub_p_dom_c_inhand_mtr_size = size(sub_parent_dom_child_inhand_mtr,1);
%     
%     sub_index_p_no_dom_c_inhand_zero = find(sub_parent_no_dom_child_inhand_mtr==0);
%     sub_index_p_no_dom_c_inhand_between = find(sub_parent_no_dom_child_inhand_mtr<1 & sub_parent_no_dom_child_inhand_mtr>0);
%     sub_index_p_no_dom_c_inhand_one = find(sub_parent_no_dom_child_inhand_mtr==1);
%     sub_p_no_dom_c_inhand_mtr_size = size(sub_parent_no_dom_child_inhand_mtr,1);
% 
% %     sub_y_p_dom_p_inhand = [numel(sub_index_p_dom_p_inhand_zero)/sub_p_dom_p_inhand_mtr_size,numel(sub_parent_no_dom_parent_inhand_mtr)/sub_p_dom_p_inhand_mtr_size,numel(sub_index_p_dom_p_inhand_one)/sub_p_dom_p_inhand_mtr_size];
% %     sub_y_p_no_dom_p_inhand = [numel(sub_index_p_no_dom_p_inhand_zero)/sub_p_no_dom_p_inhand_mtr_size,numel(sub_index_p_no_dom_p_inhand_between)/sub_p_no_dom_p_inhand_mtr_size,numel(sub_index_p_no_dom_p_inhand_one)/sub_p_no_dom_p_inhand_mtr_size];
% %     sub_y_p_dom_c_inhand = [numel(sub_index_p_dom_c_inhand_zero)/sub_p_dom_c_inhand_mtr_size,numel(sub_index_p_dom_c_inhand_between)/sub_p_dom_c_inhand_mtr_size,numel(sub_index_p_dom_c_inhand_one)/sub_p_dom_c_inhand_mtr_size];
% %     sub_y_p_no_dom_c_inhand = [numel(sub_index_p_no_dom_c_inhand_zero)/sub_p_no_dom_c_inhand_mtr_size,numel(sub_index_p_no_dom_c_inhand_between)/sub_p_no_dom_c_inhand_mtr_size,numel(sub_index_p_no_dom_c_inhand_one)/sub_p_no_dom_c_inhand_mtr_size];
% %     
% 
%     sub_y_p_dom_p_inhand = [numel(sub_parent_no_dom_parent_inhand_mtr)/sub_p_dom_p_inhand_mtr_size,numel(sub_index_p_dom_p_inhand_one)/sub_p_dom_p_inhand_mtr_size];
%     sub_y_p_no_dom_p_inhand = [numel(sub_index_p_no_dom_p_inhand_between)/sub_p_no_dom_p_inhand_mtr_size,numel(sub_index_p_no_dom_p_inhand_one)/sub_p_no_dom_p_inhand_mtr_size];
%     sub_y_p_dom_c_inhand = [numel(sub_index_p_dom_c_inhand_between)/sub_p_dom_c_inhand_mtr_size,numel(sub_index_p_dom_c_inhand_one)/sub_p_dom_c_inhand_mtr_size];
%     sub_y_p_no_dom_c_inhand = [numel(sub_index_p_no_dom_c_inhand_between)/sub_p_no_dom_c_inhand_mtr_size,numel(sub_index_p_no_dom_c_inhand_one)/sub_p_no_dom_c_inhand_mtr_size];
%     
% 
% 
%     sub_y = [sub_y_p_dom_p_inhand,sub_y_p_no_dom_p_inhand,sub_y_p_dom_c_inhand,sub_y_p_no_dom_c_inhand];
% 
%     sub_mean_prop = [sub_mean_prop;sub_y];
% end
% 
% % scatter(repmat(xtips1(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,1),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips2(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,4),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips3(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,7),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips4(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,10),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % 
% % scatter(repmat(xtips1(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,2),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips2(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,5),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips3(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,8),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips4(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,11),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % 
% % scatter(repmat(xtips1(3), size(sub_mean_prop,1), 1),sub_mean_prop(:,3),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips2(3), size(sub_mean_prop,1), 1),sub_mean_prop(:,6),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips3(3), size(sub_mean_prop,1), 1),sub_mean_prop(:,9),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% % scatter(repmat(xtips4(3), size(sub_mean_prop,1), 1),sub_mean_prop(:,12),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% 
% scatter(repmat(xtips1(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,1),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips2(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,3),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips3(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,5),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips4(1), size(sub_mean_prop,1), 1),sub_mean_prop(:,7),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% 
% scatter(repmat(xtips1(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,2),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips2(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,4),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips3(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,6),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% scatter(repmat(xtips4(2), size(sub_mean_prop,1), 1),sub_mean_prop(:,8),'Marker', 'o', 'MarkerEdgeAlpha', 0.5);
% 
% hold off
% 
% title('Effect of Visual Dominance and Manual Action on Parent''s Attention')
% xlabel('ROI Probability')
% ylabel('Proportion')
% % xticklabels({'ROI Prop. = 0','0 < ROI Prop. < 1','ROI Prop. = 1'})
% xticklabels({'0 < ROI Prop. < 1','ROI Prop. = 1'})
% 
% legend_labels = {'parent dom parent inhand','parent no dom parent inhand','parent dom child inhand','parent no dom child inhand'};
% legend(legend_labels);






% select a subset based on target object size in both views
%obj_size_child = 0.04;
%obj_size_parent = 0.02; 
%index = intersect(find(data(:,obj_size_child_col)>=obj_size_child),find(data(:,obj_size_parent_col)>=obj_size_parent)); 
%data = data(index,:); 
% inhand_time = 0.5;
% large_time = 0.2; 
% index1 = find(data(:,child_inhand_col)>inhand_time);
% index2 = find(data(:,child_largest_col)>large_time);
% index3 = find(data(:,parent_inhand_col)>inhand_time);
% index4 = find(data(:,parent_largest_col)>large_time);
% child_inhand_large = intersect(index1,index4);
% % child_inhand_large = intersect(intersect(index1,index4),index4);
% % parent_inhand_large = intersect(intersect(index3,index2),index2);
% parent_inhand_large = intersect(index3,index2);
% inhand_large = union(child_inhand_large,parent_inhand_large);
% 
% length(inhand_large)/size(data,1);
% 
% 
% 
% 
% % result
% figure(1)
% subplot(4,1,1);
% histogram(data(:,child_largest_col),'Normalization','probability');
% subplot(4,1,2);
% histogram(data(:,child_obj_size_col),'Normalization','probability');
% % subplot(4,1,3);
% % histogram(data(:,joint_attend_col),'Normalization','probability');
% % subplot(4,1,4);
% % histogram(data(:,joint_attend_col),'Normalization','probability');
% 
% subplot(4,1,3);
% histogram(data(:,parent_largest_col),'Normalization','probability');
% subplot(4,1,4);
% histogram(data(:,parent_obj_size_col),'Normalization','probability');
% %histogram(data(:,parent_inhand_col)+data(:,child_inhand_col),'Normalization','probability');
% 
% % divide baed on prop of time that the held obj is largest within a holding instance
% largest_prop = 0.50; 
% index = find (data(:,parent_largest_col)>largest_prop);
% %index2 = setdiff([1:size(data,1)],index1);
% 
% figure(2); 
% subplot(6,1,1);
% histogram(data(index,child_roi_col),'Normalization','probability');
% subplot(6,1,2);
% histogram(data(setdiff([1:size(data,1)],index),child_roi_col),'Normalization','probability');
% subplot(6,1,3);
% histogram(data(index,parent_roi_col),'Normalization','probability');
% subplot(6,1,4);
% histogram(data(setdiff([1:size(data,1)],index),parent_roi_col),'Normalization','probability');
% subplot(6,1,5);
% histogram(data(index,joint_attend_col),'Normalization','probability');
% subplot(6,1,6);
% histogram(data(setdiff([1:size(data,1)],index),joint_attend_col),'Normalization','probability');
% 
% % conditioned on child hold and parent hold
% figure(3);
% inhand_time = 0.5; 
% index1 = find(data(:,child_inhand_col)>inhand_time);
% index2 = find(data(:,parent_inhand_col)>inhand_time);
% both_inhand = intersect(index1,index2);
% subplot(4,1,1);
% histogram(data(both_inhand,child_roi_col),'Normalization','probability');
% subplot(4,1,2);
% child_only = setdiff(index1,both_inhand); 
% histogram(data(child_only,child_roi_col),'Normalization','probability');
% subplot(4,1,3);
% parent_only = setdiff(index2,both_inhand); 
% histogram(data(parent_only,child_roi_col),'Normalization','probability');
% subplot(4,1,4);
% index3=setdiff([1:size(data,1)],parent_only);
% no_inhand= setdiff(index3,child_only);
% histogram(data(no_inhand,child_roi_col),'Normalization','probability');
% 
% 
% 
% 
% 
% 
