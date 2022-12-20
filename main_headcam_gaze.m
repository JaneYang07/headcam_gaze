% %%% This version of analysis is catered for dominant objects
% 
% clear;
% exp_id = [12];
% obj_num = 24; % 24 objs for exp 12, 10 objs for exp 15
% 
% sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);
% 
% colNames = {'subId','P(roi)','P(dom)','P(roi|dominant)','P(dom|roi)','P(dom|child inhand)','P(dom|parent inhand)','P(roi|dom&child inhand)','P(roi|dom&parent inhand)','P(roi|dom&not inhand)','P(dom&not inhand)','P(dom&child inhand|roi)','P(dom&parent inhand|roi)','P(dom&not inhand|roi)','P(dom&both inhand|roi)'};
% result_matrix = zeros(0,numel(colNames));
% 
% for i = 1 : length(sub_list)
%     roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
%     dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-obj_child');
%     roi_dominant = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_roi-dominant_child');
%     child_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-inhand_child-child');
%     parent_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-inhand_child-parent');
% 
%     inhand_child_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
%     inhand_child_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
%     inhand_parent_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
%     inhand_parent_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');
% 
% 
%     rois{i} = align_streams(roi(:,1),{dominant,roi_dominant,child_hand_dom,parent_hand_dom,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});
% 
%     result_matrix(i,1) = sub_list(i);
%     % P(roi)
%     result_matrix(i,2) = sum(roi(:,2)~=0)/length(roi);
%     % P(dom)
%     result_matrix(i,3) = sum(dominant(:,2)~=0)/length(dominant);
%     % P(roi|dominant)
%     result_matrix(i,4) = sum(roi_dominant(:,2)~=0)/sum(dominant(:,2)~=0);
%     % P(dom|roi)
%     result_matrix(i,5) = sum(roi_dominant(:,2)~=0)/sum(roi(:,2)~=0);
%     % P(dom|child inhand)
%     child_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)~=0 & ~isnan(inhand_child_left(:,2)) & ~isnan(inhand_child_right(:,2))),1);
%     result_matrix(i,6) = sum(child_hand_dom(:,2)~=0)/child_inhand_num;
%     % P(dom|parent inhand)
%     parent_inhand_num = size(find(inhand_parent_left(:,2)+inhand_parent_right(:,2)~=0 & ~isnan(inhand_parent_left(:,2)) & ~isnan(inhand_parent_right(:,2))),1);
%     result_matrix(i,7) = sum(parent_hand_dom(:,2)~=0)/parent_inhand_num;
%     
%     % find match pattern: dom&child inhand&roi
%     match_index_child_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,3))==0);
%     child_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
%     child_inhand_dominant_roi(match_index_child_hand_dom_roi,2) = roi(match_index_child_hand_dom_roi,2);
% 
%     % find match pattern: dom&parent inhand&roi
%     match_index_parent_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,4))==0);
%     parent_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
%     parent_inhand_dominant_roi(match_index_parent_hand_dom_roi,2) = roi(match_index_parent_hand_dom_roi,2);
% 
%     % P(roi|dom&child inhand)
%     result_matrix(i,8) = sum(child_inhand_dominant_roi(:,2)~=0)/sum(child_hand_dom(:,2)~=0);
%     % P(roi|dom&parent inhand)
%     result_matrix(i,9) = sum(parent_inhand_dominant_roi(:,2)~=0)/sum(parent_hand_dom(:,2)~=0);
% 
% 
%     % P(roi|dom&not inhand)    
%     % find match pattern: dom&not inhand&roi
%     % Step 1: find match condition: dom&not inhand
%     not_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0),1);
% %     not_inhand_index = find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0);
%     dom_not_inhand_child_left = find(abs(rois{i}(:,1)-rois{i}(:,5))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,5))));
%     dom_not_inhand_child_right = find(abs(rois{i}(:,1)-rois{i}(:,6))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,6))));
%     dom_not_inhand_parent_left = find(abs(rois{i}(:,1)-rois{i}(:,7))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,7))));
%     dom_not_inhand_parent_right = find(abs(rois{i}(:,1)-rois{i}(:,8))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,8))));
%     dom_not_inhand_child = intersect(dom_not_inhand_child_left,dom_not_inhand_child_right);
%     dom_not_inhand_parent = intersect(dom_not_inhand_parent_left,dom_not_inhand_parent_right);
%     not_inhand_index = intersect(dom_not_inhand_child,dom_not_inhand_parent);
%     
%     match_index_dom_not_inhand = intersect(find(rois{i}(:,1)~=0),not_inhand_index);
%     dom_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
%     dom_not_inhand(match_index_dom_not_inhand,2) = rois{i}(match_index_dom_not_inhand,1);
% 
%     % Step 2: find match condition: roi&dom&not inhand
%     match_index_roi_dom_not_inhand = intersect(find(abs(rois{i}(:,2)-dom_not_inhand(:,2))==0),find(rois{i}(:,2)~=0));
%     roi_dom_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
%     roi_dom_not_inhand(match_index_roi_dom_not_inhand,2) = roi(match_index_roi_dom_not_inhand,2);
% 
%     % Step 3: find P(roi|dom&not inhand) 
%     % = P(roi&dom&not inhand)/P(dom&not inhand)
%     result_matrix(i,10) = sum(roi_dom_not_inhand(:,2)~=0)/sum(dom_not_inhand(:,2)~=0);
% 
%     % P(dom&not inhand)
%     result_matrix(i,11) = sum(dom_not_inhand(:,2)~=0)/length(dom_not_inhand);
% 
%     % P(dom&child inhand|roi)
%     result_matrix(i,12) = sum(child_inhand_dominant_roi(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(dom&parent inhand|roi)
%     result_matrix(i,13) = sum(parent_inhand_dominant_roi(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(dom&not inhand|roi)
%     result_matrix(i,14) = sum(roi_dom_not_inhand(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(dom&both inhand|roi)
%     match_index_roi_dom_both_inhand = intersect(match_index_child_hand_dom_roi,match_index_parent_hand_dom_roi);
%     dominant_roi_both_hand = [roi(:,1) zeros(size(roi,1),1)];
%     dominant_roi_both_hand(match_index_roi_dom_both_inhand,2) = roi(match_index_roi_dom_both_inhand,2);
%     result_matrix(i,15) = sum(dominant_roi_both_hand(:,2)~=0)/sum(roi(:,2)~=0);
% end
% 
% result_table = array2table(result_matrix,'VariableNames',colNames);
% writetable(result_table,'result_table_dominant_updated.csv');
% 
% 
% 
% 
% 
% %%% Another version of analysis but with largest obj instead of dominant obj
% 
% 
% clear;
% exp_id = [12];
% obj_num = 24; % 24 objs for exp 12, 10 objs for exp 15
% 
% sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);
% 
% colNames = {'subId','P(roi)','P(largest)','P(roi|largest)','P(largest|roi)','P(largest|child inhand)','P(largest|parent inhand)','P(roi|largest&child inhand)','P(roi|largest&parent inhand)','P(roi|largest&not inhand)','P(largest&not inhand)','P(largest&child inhand|roi)','P(largest&parent inhand|roi)','P(largest&not inhand|roi)','P(largest&both inhand|roi)'};
% result_matrix = zeros(0,numel(colNames));
% 
% for i = 1 : length(sub_list)
%     % load all relevant variables
%     roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
%     largest = get_variable_by_trial_cat(sub_list(i),'cstream_vision_largest-obj_child');
%     roi_largest = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_roi-largest_child');
%     child_hand_largest = get_variable_by_trial_cat(sub_list(i),'cstream_vision_largest-inhand_child-child');
%     parent_hand_largest = get_variable_by_trial_cat(sub_list(i),'cstream_vision_largest-inhand_child-parent');
% 
%     inhand_child_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
%     inhand_child_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
%     inhand_parent_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
%     inhand_parent_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');
% 
%     % align all variables with roi's timestamp
%     rois{i} = align_streams(roi(:,1),{largest,roi_largest,child_hand_largest,parent_hand_largest,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});
%     
%     % record subID to the result matrix
%     result_matrix(i,1) = sub_list(i);
% 
%     % P(roi)
%     result_matrix(i,2) = sum(roi(:,2)~=0)/length(roi);
%     % P(largest)
%     result_matrix(i,3) = sum(largest(:,2)~=0)/length(largest);
%     % P(roi|largest)
%     result_matrix(i,4) = sum(roi_largest(:,2)~=0)/sum(largest(:,2)~=0);
%     % P(largest|roi)
%     result_matrix(i,5) = sum(roi_largest(:,2)~=0)/sum(roi(:,2)~=0);
%     % P(largest|child inhand)
%     child_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)~=0 & ~isnan(inhand_child_left(:,2)) & ~isnan(inhand_child_right(:,2))),1);
%     result_matrix(i,6) = sum(child_hand_largest(:,2)~=0)/child_inhand_num;
%     % P(largest|parent inhand)
%     parent_inhand_num = size(find(inhand_parent_left(:,2)+inhand_parent_right(:,2)~=0 & ~isnan(inhand_parent_left(:,2)) & ~isnan(inhand_parent_right(:,2))),1);
%     result_matrix(i,7) = sum(parent_hand_largest(:,2)~=0)/parent_inhand_num;
%     
%     % find match pattern: largest&child inhand&roi
%     match_index_child_hand_largest_roi = find(abs(roi(:,2)-rois{i}(:,3))==0);
%     child_inhand_largest_roi = [roi(:,1) zeros(size(roi,1),1)];
%     child_inhand_largest_roi(match_index_child_hand_largest_roi,2) = roi(match_index_child_hand_largest_roi,2);
% 
%     % find match pattern: largest&parent inhand&roi
%     match_index_parent_hand_largest_roi = find(abs(roi(:,2)-rois{i}(:,4))==0);
%     parent_inhand_largest_roi = [roi(:,1) zeros(size(roi,1),1)];
%     parent_inhand_largest_roi(match_index_parent_hand_largest_roi,2) = roi(match_index_parent_hand_largest_roi,2);
% 
%     % P(roi|largest&child inhand)
%     result_matrix(i,8) = sum(child_inhand_largest_roi(:,2)~=0)/sum(child_hand_largest(:,2)~=0);
%     % P(roi|largest&parent inhand)
%     result_matrix(i,9) = sum(parent_inhand_largest_roi(:,2)~=0)/sum(parent_hand_largest(:,2)~=0);
% 
% 
%     % P(roi|largest&not inhand)    
%     % find match pattern: largest&not inhand&roi
%     % Step 1: find match condition: largest&not inhand
%     not_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0),1);
% %     not_inhand_index = find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0);
%     largest_not_inhand_child_left = find(abs(rois{i}(:,1)-rois{i}(:,5))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,5))));
%     largest_not_inhand_child_right = find(abs(rois{i}(:,1)-rois{i}(:,6))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,6))));
%     largest_not_inhand_parent_left = find(abs(rois{i}(:,1)-rois{i}(:,7))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,7))));
%     largest_not_inhand_parent_right = find(abs(rois{i}(:,1)-rois{i}(:,8))~=0 & ~isnan(abs(rois{i}(:,1)-rois{i}(:,8))));
%     largest_not_inhand_child = intersect(largest_not_inhand_child_left,largest_not_inhand_child_right);
%     largest_not_inhand_parent = intersect(largest_not_inhand_parent_left,largest_not_inhand_parent_right);
%     not_inhand_index = intersect(largest_not_inhand_child,largest_not_inhand_parent);
%     
%     match_index_largest_not_inhand = intersect(find(rois{i}(:,1)~=0),not_inhand_index);
%     largest_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
%     largest_not_inhand(match_index_largest_not_inhand,2) = rois{i}(match_index_largest_not_inhand,1);
% 
%     % Step 2: find match condition: roi&largest&not inhand
%     match_index_roi_largest_not_inhand = intersect(find(abs(rois{i}(:,2)-largest_not_inhand(:,2))==0),find(rois{i}(:,2)~=0));
%     roi_largest_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
%     roi_largest_not_inhand(match_index_roi_largest_not_inhand,2) = roi(match_index_roi_largest_not_inhand,2);
% 
%     % Step 3: find P(roi|largest&not inhand) 
%     % = P(roi&largest&not inhand)/P(largest&not inhand)
%     result_matrix(i,10) = sum(roi_largest_not_inhand(:,2)~=0)/sum(largest_not_inhand(:,2)~=0);
% 
%     % P(largest&not inhand)
%     result_matrix(i,11) = sum(largest_not_inhand(:,2)~=0)/length(largest_not_inhand);
% 
% 
%     % P(largest&child inhand|roi)
%     result_matrix(i,12) = sum(child_inhand_largest_roi(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(largest&parent inhand|roi)
%     result_matrix(i,13) = sum(parent_inhand_largest_roi(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(largest&not inhand|roi)
%     result_matrix(i,14) = sum(roi_largest_not_inhand(:,2)~=0)/sum(roi(:,2)~=0);
% 
%     % P(largest&both inhand|roi)
%     match_index_roi_largest_both_inhand = intersect(match_index_child_hand_largest_roi,match_index_parent_hand_largest_roi);
%     largest_roi_both_hand = [roi(:,1) zeros(size(roi,1),1)];
%     largest_roi_both_hand(match_index_roi_largest_both_inhand,2) = roi(match_index_roi_largest_both_inhand,2);
%     result_matrix(i,15) = sum(largest_roi_both_hand(:,2)~=0)/sum(roi(:,2)~=0);
% 
% end
% 
% result_table = array2table(result_matrix,'VariableNames',colNames);
% writetable(result_table,'result_table_largest_updated.csv');
% 
% 
% 
% 




%%% Latest version of analysis

clear;
exp_id = [12];
obj_num = 24; % 24 objs for exp 12, 10 objs for exp 15

sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);

colNames = {'subId','num_frame','num_roi','num_dom','num_overlap_match','num_overlap_mismatch','num_roi_not_dom', 'num_dom_not_roi','num_not_roi_and_not_dom'};
result_matrix = zeros(0,numel(colNames));

for i = 1 : length(sub_list)
    roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-obj_child');
    roi_dominant = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_roi-dominant_child');
    child_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-inhand_child-child');
    parent_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-inhand_child-parent');

    inhand_child_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');


    rois{i} = align_streams(roi(:,1),{dominant,roi_dominant,child_hand_dom,parent_hand_dom,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});

    result_matrix(i,1) = sub_list(i);
    % num_frame
    num_frame = length(roi);
    result_matrix(i,2) = num_frame;
    % num_roi
    num_roi = sum(roi(:,2)~=0 & ~isnan(roi(:,2)));
    result_matrix(i,3) = num_roi;
    % num_dom
    num_dom = sum(rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1)));
    result_matrix(i,4) = num_dom;
    % num_overlap_match
    num_match = sum(rois{i}(:,2)~=0 & ~isnan(rois{i}(:,2)));
    result_matrix(i,5) = num_match;
    % num_overlap_mismatch
    num_mismatch = size(find(abs(roi(:,2)-rois{i}(:,1))~=0 & roi(:,2)~=0 & ~isnan(roi(:,2)) & rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1))),1);
    result_matrix(i,6) = num_mismatch;

    % num_roi_not_dom
    num_roi_not_dom = size(find((roi(:,2)~=0 & ~isnan(roi(:,2))) & (roi(:,2)-rois{i}(:,1)==roi(:,2) | isnan(abs(roi(:,2)-rois{i}(:,1))))),1);
    result_matrix(i,7) = num_roi_not_dom;

    % num_dom_not_roi
    num_dom_not_roi = size(find((rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1))) & (rois{i}(:,1)-roi(:,2)==rois{i}(:,1) | isnan(abs(rois{i}(:,1)-roi(:,2))))),1);
    result_matrix(i,8) = num_dom_not_roi;

    % num_not_roi_and_not_dom
    num_not_roi_and_not_dom = size(find((abs(roi(:,2)-rois{i}(:,1))==0 | isnan(abs(roi(:,2)-rois{i}(:,1)))) & (roi(:,2)==0 | isnan(roi(:,2))) & (rois{i}(:,1)==0 | isnan(rois{i}(:,1)))),1);
    result_matrix(i,9) = num_not_roi_and_not_dom;
end

result_table = array2table(result_matrix,'VariableNames',colNames);
writetable(result_table,'result_table_new.csv');



