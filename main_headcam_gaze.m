clear;
exp_id = [12,15];
obj_num = 24; % 24 objs for exp 12, 10 objs for exp 15

sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);

colNames = {'subId','P(roi)','P(dom)','P(roi|dominant)','P(dom|roi)','P(dom|child inhand)','P(dom|parent inhand)','P(roi|dom&child inhand)','P(roi|dom&parent inhand)','P(roi|dom&not inhand)','P(dom&not inhand)'};
result_matrix = zeros(0,numel(colNames));

for i = 1 : length(sub_list)
    roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant_child');
    roi_dominant = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_largest-dominant-roi_child');
    child_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant-child-inhand');
    parent_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant-parent-inhand');

    inhand_child_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');


    rois{i} = align_streams(roi(:,1),{dominant,roi_dominant,child_hand_dom,parent_hand_dom,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});

    result_matrix(i,1) = sub_list(i);
    % P(roi)
    result_matrix(i,2) = sum(roi(:,2)~=0)/length(roi);
    % P(dom)
    result_matrix(i,3) = sum(dominant(:,2)~=0)/length(dominant);
    % P(roi|dominant)
    result_matrix(i,4) = sum(roi_dominant(:,2)~=0)/sum(dominant(:,2)~=0);
    % P(dom|roi)
    result_matrix(i,5) = sum(roi_dominant(:,2)~=0)/sum(roi(:,2)~=0);
    % P(dom|child inhand)
    child_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)~=0),1);
    result_matrix(i,6) = sum(child_hand_dom(:,2)~=0)/child_inhand_num;
    % P(dom|parent inhand)
    parent_inhand_num = size(find(inhand_parent_left(:,2)+inhand_parent_right(:,2)~=0),1);
    result_matrix(i,7) = sum(parent_hand_dom(:,2)~=0)/parent_inhand_num;
    
    % find match pattern: dom&child inhand&roi
    match_index_child_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,3))==0);
    child_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
    child_inhand_dominant_roi(match_index_child_hand_dom_roi,2) = roi(match_index_child_hand_dom_roi,2);

    % find match pattern: dom&parent inhand&roi
    match_index_parent_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,4))==0);
    parent_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
    parent_inhand_dominant_roi(match_index_parent_hand_dom_roi,2) = roi(match_index_parent_hand_dom_roi,2);

    % P(roi|dom&child inhand)
    result_matrix(i,8) = sum(child_inhand_dominant_roi(:,2)~=0)/sum(child_hand_dom(:,2)~=0);
    % P(roi|dom&parent inhand)
    result_matrix(i,9) = sum(parent_inhand_dominant_roi(:,2)~=0)/sum(parent_hand_dom(:,2)~=0);


    % P(roi|dom&not inhand)    
    % find match pattern: dom&not inhand&roi
    % Step 1: find match condition: dom&not inhand
    not_inhand_num = size(find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0),1);
%     not_inhand_index = find(inhand_child_left(:,2)+inhand_child_right(:,2)+inhand_parent_left(:,2)+inhand_parent_right(:,2)==0);
    dom_not_inhand_child_left = find(abs(rois{i}(:,1)-rois{i}(:,5))~=0);
    dom_not_inhand_child_right = find(abs(rois{i}(:,1)-rois{i}(:,6))~=0);
    dom_not_inhand_parent_left = find(abs(rois{i}(:,1)-rois{i}(:,7))~=0);
    dom_not_inhand_parent_right = find(abs(rois{i}(:,1)-rois{i}(:,8))~=0);
    dom_not_inhand_child = intersect(dom_not_inhand_child_left,dom_not_inhand_child_right);
    dom_not_inhand_parent = intersect(dom_not_inhand_parent_left,dom_not_inhand_parent_right);
    not_inhand_index = intersect(dom_not_inhand_child,dom_not_inhand_parent);
    
    match_index_dom_not_inhand = intersect(find(rois{i}(:,1)~=0),not_inhand_index);
    dom_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
    dom_not_inhand(match_index_dom_not_inhand,2) = rois{i}(match_index_dom_not_inhand,1);

    % Step 2: find match condition: roi&dom&not inhand
    match_index_roi_dom_not_inhand = intersect(find(abs(rois{i}(:,2)-dom_not_inhand(:,2))==0),find(rois{i}(:,2)~=0));
    roi_dom_not_inhand = [roi(:,1) zeros(size(roi,1),1)];
    roi_dom_not_inhand(match_index_roi_dom_not_inhand,2) = roi(match_index_roi_dom_not_inhand,2);

    % Step 3: find P(roi|dom&not inhand) 
    % = P(roi&dom&not inhand)/P(dom&inhand)
    result_matrix(i,10) = sum(roi_dom_not_inhand(:,2)~=0)/sum(dom_not_inhand(:,2)~=0);

    % P(dom&not inhand)
    result_matrix(i,11) = sum(dom_not_inhand(:,2)~=0)/length(dom_not_inhand);

end

result_table = array2table(result_matrix,'VariableNames',colNames);
writetable(result_table,'result_table.csv');