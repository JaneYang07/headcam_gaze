clear;
exp_id = [12];
obj_num = 24; % 24 objs for exp 12, 10 objs for exp 15

% venn diagram for roi, dom, child_inhand, and parent_inhand
% needed: roi, dom, child_inhand, and parent_inhand
%         roi&dom, roi&child_inhand, roi&parent_inhand, dom&child_inhand,
%         dom&parent_inhand, child_inhand&parent_inhand
%         roi&dom&child_inhand, roi&dom&parent_inhand,
%         roi&child_inhand&parent_inhand, dom&child_inhand&parent_inhand
%         roi&dom&child_inhand&parent_inhand

sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);
colNames = {'subId','num_roi','num_dom','num_child_inhand','num_parent_inhand','num_roi_dom','num_roi_child-inhand','num_roi_parent-inhand','num_dom_child-inhand','num_dom_parent-inhand','num_child-parent-inhand','num_roi_dom_child-inhand','num_roi_dom_parent-inhand','num_roi_child-parent-inhand','num_dom_child-parent-inhand','num_roi_dom_child-parent-inhand'};
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


    % num_roi
    num_roi = sum(roi(:,2)~=0 & ~isnan(roi(:,2)));
    result_matrix(i,2) = num_roi;
    % num_dom
    num_dom = sum(rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1)));
    result_matrix(i,3) = num_dom;
    % child_inhand
    num_child_inhand = sum((rois{i}(:,5)~=0 & ~isnan(rois{i}(:,5))) | (rois{i}(:,6)~=0 & ~isnan(rois{i}(:,6))));
    result_matrix(i,4) = num_child_inhand;
    % parent_inhand
    num_parent_inhand = sum((rois{i}(:,7)~=0 & ~isnan(rois{i}(:,7))) | (rois{i}(:,8)~=0 & ~isnan(rois{i}(:,8))));
    result_matrix(i,5) = num_parent_inhand;
    % roi&dom
    num_roi_dom = sum(rois{i}(:,2)~=0 & ~isnan(rois{i}(:,2)));
    result_matrix(i,6) = num_roi_dom;
    % roi&child_inhand
    match_index_roi_child_inhand = union(find(abs(roi(:,2)-rois{i}(:,5))==0 & roi(:,2)~=0 & rois{i}(:,5)~=0 & ~isnan(rois{i}(:,5)) & ~isnan(roi(:,2)~=0)),find(abs(roi(:,2)-rois{i}(:,6))==0 & roi(:,2)~=0 & rois{i}(:,6)~=0 & ~isnan(rois{i}(:,6)) & ~isnan(roi(:,2)~=0)));
    num_roi_child_inhand = size(match_index_roi_child_inhand,1);
    roi_child_inhand = [roi(:,1) zeros(size(roi,1),1)];
    roi_child_inhand(match_index_roi_child_inhand,2) = roi(match_index_roi_child_inhand,2);
    result_matrix(i,7) = num_roi_child_inhand;

    % roi&parent_inhand
    match_index_roi_parent_inhand = union(find(abs(roi(:,2)-rois{i}(:,7))==0 & roi(:,2)~=0 & rois{i}(:,7)~=0 & ~isnan(rois{i}(:,7)) & ~isnan(roi(:,2)~=0)),find(abs(roi(:,2)-rois{i}(:,8))==0 & roi(:,2)~=0 & rois{i}(:,8)~=0 & ~isnan(rois{i}(:,8)) & ~isnan(roi(:,2)~=0)));
    num_roi_parent_inhand = size(match_index_roi_parent_inhand,1);
    roi_parent_inhand = [roi(:,1) zeros(size(roi,1),1)];
    roi_parent_inhand(match_index_roi_parent_inhand,2) = roi(match_index_roi_parent_inhand,2);
    result_matrix(i,8) = num_roi_parent_inhand;

    % dom&child_inhand
    num_dom_child_inhand = sum(rois{i}(:,3)~=0 & ~isnan(rois{i}(:,3)));
    result_matrix(i,9) = num_dom_child_inhand;
    % dom&parent_inhand
    num_dom_parent_inhand = sum(rois{i}(:,4)~=0 & ~isnan(rois{i}(:,4)));
    result_matrix(i,10) = num_dom_parent_inhand;

    
    % child_inhand&parent_inhand
    match_index_child_left_match = union(find((rois{i}(:,5)~=0 & rois{i}(:,7)~=0) & (~isnan(rois{i}(:,5)) & ~isnan(rois{i}(:,7))) & abs(rois{i}(:,5)-rois{i}(:,7))==0),find((rois{i}(:,5)~=0 & rois{i}(:,8)~=0) & (~isnan(rois{i}(:,5)) & ~isnan(rois{i}(:,8))) & abs(rois{i}(:,5)-rois{i}(:,8))==0));
    match_index_child_right_match = union(find((rois{i}(:,6)~=0 & rois{i}(:,7)~=0) & (~isnan(rois{i}(:,6)) & ~isnan(rois{i}(:,7))) & abs(rois{i}(:,6)-rois{i}(:,7))==0),find((rois{i}(:,6)~=0 & rois{i}(:,8)~=0) & (~isnan(rois{i}(:,6)) & ~isnan(rois{i}(:,8))) & abs(rois{i}(:,6)-rois{i}(:,8))==0));
    match_index_child_parent_match = union(match_index_child_left_match, match_index_child_right_match);
    num_child_parent_inhand = size(match_index_child_parent_match,1);
    result_matrix(i,11) = num_child_parent_inhand;

    % roi&dom&child_inhand
    match_index_roi_dom_child_inhand = find(abs(roi(:,2)-rois{i}(:,3))==0 & roi(:,2)~=0 & rois{i}(:,3)~=0 & ~isnan(rois{i}(:,3)) & ~isnan(roi(:,2)~=0));
    roi_child_inhand_dom = [roi(:,1) zeros(size(roi,1),1)];
    roi_child_inhand_dom(match_index_roi_dom_child_inhand,2) = roi(match_index_roi_dom_child_inhand,2);
    num_roi_dom_child_inhand = size(match_index_roi_dom_child_inhand,1);
    result_matrix(i,12) = num_roi_dom_child_inhand;

    % roi&dom&parent_inhand
    match_index_roi_dom_parent_hand = find(abs(roi(:,2)-rois{i}(:,4))==0 & roi(:,2)~=0 & rois{i}(:,4)~=0 & ~isnan(rois{i}(:,4)) & ~isnan(roi(:,2)~=0));
    roi_dom_parent_inhand = [roi(:,1) zeros(size(roi,1),1)];
    roi_dom_parent_inhand(match_index_roi_dom_parent_hand,2) = roi(match_index_roi_dom_parent_hand,2);
    num_roi_dom_parent_inhand = size(match_index_roi_dom_parent_hand,1);
    result_matrix(i,13) = num_roi_dom_parent_inhand;

    % roi&child_inhand&parent_inhand
    match_index_roi_child_left_match = union(find((rois{i}(:,5)~=0 & rois{i}(:,7)~=0 ) & (~isnan(rois{i}(:,5)) & ~isnan(rois{i}(:,7))) & abs(rois{i}(:,5)-rois{i}(:,7))==0 & abs(roi(:,2)-rois{i}(:,5))==0),find((rois{i}(:,5)~=0 & rois{i}(:,8)~=0) & (~isnan(rois{i}(:,5)) & ~isnan(rois{i}(:,8))) & abs(rois{i}(:,5)-rois{i}(:,8))==0 & abs(roi(:,2)-rois{i}(:,5))==0));
    match_index_roi_child_right_match = union(find((rois{i}(:,6)~=0 & rois{i}(:,7)~=0) & (~isnan(rois{i}(:,6)) & ~isnan(rois{i}(:,7))) & abs(rois{i}(:,6)-rois{i}(:,7))==0 & abs(roi(:,2)-rois{i}(:,6))==0),find((rois{i}(:,6)~=0 & rois{i}(:,8)~=0) & (~isnan(rois{i}(:,6)) & ~isnan(rois{i}(:,8))) & abs(rois{i}(:,6)-rois{i}(:,8))==0 & abs(roi(:,2)-rois{i}(:,6))==0));
    match_index_roi_child_parent_match = union(match_index_roi_child_left_match, match_index_roi_child_right_match);
    num_roi_child_parent_inhand = size(match_index_roi_child_parent_match,1);
    result_matrix(i,14) = num_roi_child_parent_inhand;

    % dom&child_inhand&parent_inhand
    match_index_dom_child_parent_match = find(abs(rois{i}(:,3)-rois{i}(:,4))==0 & rois{i}(:,3)~=0 & rois{i}(:,4)~=0 & ~isnan(rois{i}(:,3)) & ~isnan(rois{i}(:,4)));
    num_dom_child_parent_inhand = size(match_index_dom_child_parent_match,1);
    result_matrix(i,15) = num_dom_child_parent_inhand;

    % roi&dom&child_inhand&parent_inhand
    num_roi_dom_child_parent_inhand = sum(rois{i}(match_index_dom_child_parent_match,2)~=0);
    result_matrix(i,16) = num_roi_dom_child_parent_inhand;

end

result_table = array2table(result_matrix,'VariableNames',colNames);
writetable(result_table,'result_table_venn_diagram_updated.csv');