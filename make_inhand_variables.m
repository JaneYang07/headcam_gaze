clear;

exp_id = [12];
obj_num = 24;


sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);


for i = 1 : length(sub_list)
    % load all relevant variables
    roi = get_variable(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable(sub_list(i),'cstream_vision_dominant-obj_child');
    
    inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    % align variables with roi's timestamp
    rois{i} = align_streams(roi(:,1), {dominant,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});


    % find matched condition: child holding only
    match_index_child_inhand_only = union(find(abs(rois{i}(:,1)-rois{i}(:,2))==0 & abs(rois{i}(:,1)-rois{i}(:,4))~=0 & abs(rois{i}(:,1)-rois{i}(:,5))~=0),find(abs(rois{i}(:,1)-rois{i}(:,3))==0 & abs(rois{i}(:,1)-rois{i}(:,4))~=0 & abs(rois{i}(:,1)-rois{i}(:,5))~=0));
    cstream_dom_child_holding_only = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_child_holding_only(match_index_child_inhand_only,2) = rois{i}(match_index_child_inhand_only,1);
    cevent_dom_child_holding_only = cstream2cevent(cstream_dom_child_holding_only);

    % record variables
    delete_variables(sub_list(i),'cstream_vision_dominant-inhand_child-child');
    record_additional_variable(sub_list(i),'cstream_vision_dom-child-inhand_child', cstream_dom_child_holding_only);
    record_additional_variable(sub_list(i),'cevent_vision_dom-child-inhand_child', cevent_dom_child_holding_only);

    % find matched condition: parent holding only
    match_index_parent_inhand_only = union(find(abs(rois{i}(:,1)-rois{i}(:,4))==0 & abs(rois{i}(:,1)-rois{i}(:,2))~=0 & abs(rois{i}(:,1)-rois{i}(:,3))~=0),find(abs(rois{i}(:,1)-rois{i}(:,5))==0 & abs(rois{i}(:,1)-rois{i}(:,2))~=0 & abs(rois{i}(:,1)-rois{i}(:,3))~=0));
    cstream_dom_parent_holding_only = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_parent_holding_only(match_index_parent_inhand_only,2) = rois{i}(match_index_parent_inhand_only,1);
    cevent_dom_parent_holding_only = cstream2cevent(cstream_dom_parent_holding_only);

    % record variables
    delete_variables(sub_list(i),'cstream_vision_dominant-inhand_child-parent');
    record_additional_variable(sub_list(i),'cstream_vision_dom-parent-inhand_child', cstream_dom_parent_holding_only);
    record_additional_variable(sub_list(i),'cevent_vision_dom-parent-inhand_child', cevent_dom_parent_holding_only);



    % find matched condition: joint holding
    match_index_child_left_match = union(find(abs(rois{i}(:,2)-rois{i}(:,4))==0),find(abs(rois{i}(:,2)-rois{i}(:,5))==0));
    match_index_child_right_match = union(find(abs(rois{i}(:,3)-rois{i}(:,4))==0),find(abs(rois{i}(:,3)-rois{i}(:,5))==0));
    match_index_joint_holding = union(match_index_child_left_match,match_index_child_right_match);
    cstream_dom_joint_holding = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_joint_holding(match_index_joint_holding,2) = rois{i}(match_index_joint_holding,1);
    cevent_dom_joint_holding = cstream2cevent(cstream_dom_joint_holding);

    % record variables
    record_additional_variable(sub_list(i),'cstream_vision_dom-joint-inhand_child', cstream_dom_joint_holding);
    record_additional_variable(sub_list(i),'cevent_vision_dom-joint-inhand_child', cevent_dom_joint_holding);


    % find matched condition: not hold by neither
    match_index_not_inhand = find(abs(rois{i}(:,2)-rois{i}(:,4))~=0 & abs(rois{i}(:,2)-rois{i}(:,5))~=0 & abs(rois{i}(:,3)-rois{i}(:,4))~=0 & abs(rois{i}(:,3)-rois{i}(:,5))~=0);
    cstream_dom_not_holding = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_not_holding(match_index_not_inhand,2) = rois{i}(match_index_not_inhand,1);
    cevent_dom_not_holding = cstream2cevent(cstream_dom_not_holding);

    % record variables
    record_additional_variable(sub_list(i),'cstream_vision_dom-joint-inhand_child', cstream_dom_not_holding);
    record_additional_variable(sub_list(i),'cevent_vision_dom-joint-inhand_child', cevent_dom_not_holding);

end