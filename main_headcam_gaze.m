clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

colNames = {'subId','P(roi)','P(dom)','P(roi|dominant)','P(dom|roi)','P(dom|parent inhand)','P(dom|child inhand)','P(roi|dom&child inhand)','P(roi|dom&parent inhand)','P(roi|dom&not inhand)'};
result_matrix = zeros(0,numel(colNames));

for i = 1 : length(sub_list)
    roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant_child');
    roi_dominant = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_largest-dominant-roi_child');
    child_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant-child-inhand');
    parent_hand_dom = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest-dominant-parent-inhand');


    rois{i} = align_streams(roi(:,1),{dominant,roi_dominant,child_hand_dom,parent_hand_dom});

    result_matrix(i,1) = sub_list(i);
    % P(roi)
    result_matrix(i,2) = sum(roi(:,2)~=0)/length(roi);
    % P(dom)
    result_matrix(i,3) = sum(dominant(:,2)~=0)/length(dominant);
    % P(roi|dominant)
    result_matrix(i,4) = sum(roi_dominant(:,2)~=0)/sum(roi(:,2)~=0);
    % P(dom|roi)
    result_matrix(i,5) = sum(roi_dominant(:,2)~=0)/sum(dominant(:,2)~=0);
    % P(dom|parent inhand)
    result_matrix(i,6) = sum(child_hand_dom(:,2)~=0)/sum(dominant(:,2)~=0);
    % P(dom|child inhand)
    result_matrix(i,7) = sum(parent_hand_dom(:,2)~=0)/sum(dominant(:,2)~=0);
    
    % find match pattern: dom&child inhand&roi
    match_index_child_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,3))==0);
    child_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
    child_inhand_dominant_roi(match_index_child_hand_dom_roi,2) = roi(match_index_child_hand_dom_roi,2);

    % find match pattern: dom&parent inhand&roi
    match_index_parent_hand_dom_roi = find(abs(roi(:,2)-rois{i}(:,4))==0);
    parent_inhand_dominant_roi = [roi(:,1) zeros(size(roi,1),1)];
    parent_inhand_dominant_roi(match_index_parent_hand_dom_roi,2) = roi(match_index_parent_hand_dom_roi,2);

    % P(roi|dom&child inhand)
    result_matrix(i,8) = sum(child_inhand_dominant_roi(:,2)~=0)/sum(roi(:,2)~=0);
    % P(roi|dom&parent inhand)
    result_matrix(i,9) = sum(parent_inhand_dominant_roi(:,2)~=0)/sum(roi(:,2)~=0);


    % find match pattern: dom&not inhand&roi

    % P(roi|dom&not inhand)
    dom_not_inhand = sum(roi_dominant(:,2)~=0);
    result_matrix(i,10) = 0;

end

result_table = array2table(result_matrix,'VariableNames',colNames);
