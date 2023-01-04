clear;

exp_id = [12];
obj_num = 24;


sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);

for i = 1 : length(sub_list)
    % load all relevant variables
    roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-obj_child');
    
    inhand_child_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    inhand_child_left(isnan(inhand_child_left(:,2)),2) = 0;
    inhand_child_right(isnan(inhand_child_right(:,2)),2) = 0;
    inhand_parent_left(isnan(inhand_parent_left(:,2)),2) = 0;
    inhand_parent_right(isnan(inhand_parent_right(:,2)),2) = 0;


    roi(:,1) = round(roi(:,1),4);
    dominant(:,1) = round(dominant(:,1),4);
    inhand_child_left(:,1) = round(inhand_child_left(:,1),4);
    inhand_child_right(:,1) = round(inhand_child_right(:,1),4);
    inhand_parent_left(:,1) = round(inhand_parent_left(:,1),4);
    inhand_parent_right(:,1) = round(inhand_parent_right(:,1),4);

    % align variables with roi's timestamp
    rois{i} = align_streams(roi(:,1), {dominant,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});


    % find matched condition: child holding only
    %match_index_child_inhand_only = union(find(abs(rois{i}(:,1)-rois{i}(:,2))==0 & abs(rois{i}(:,1)-rois{i}(:,4))~=0 & abs(rois{i}(:,1)-rois{i}(:,5))~=0),find(abs(rois{i}(:,1)-rois{i}(:,3))==0 & abs(rois{i}(:,1)-rois{i}(:,4))~=0 & abs(rois{i}(:,1)-rois{i}(:,5))~=0));
    match_index_child_inhand_only = union(find((rois{i}(:,1)==rois{i}(:,2)) & (rois{i}(:,1)~=rois{i}(:,4)) & (rois{i}(:,1)~=rois{i}(:,5))),find((rois{i}(:,1)==rois{i}(:,3)) & (rois{i}(:,1)~=rois{i}(:,4)) & (rois{i}(:,1)~=rois{i}(:,5))));
    cstream_dom_child_holding_only = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_child_holding_only(match_index_child_inhand_only,2) = rois{i}(match_index_child_inhand_only,1);
    cevent_dom_child_holding_only = cstream2cevent(cstream_dom_child_holding_only);

    % record variables
    %delete_variables(sub_list(i),'cstream_vision_dominant-inhand_child-child');
%     record_additional_variable(sub_list(i),'cstream_vision_dom-child-inhand_child', cstream_dom_child_holding_only);
%     record_additional_variable(sub_list(i),'cevent_vision_dom-child-inhand_child', cevent_dom_child_holding_only);

    % find matched condition: parent holding only
    match_index_parent_inhand_only = union(find((rois{i}(:,1)==rois{i}(:,4)) & (rois{i}(:,1)~=rois{i}(:,2)) & (rois{i}(:,1)~=rois{i}(:,3))),find((rois{i}(:,1)==rois{i}(:,5)) & (rois{i}(:,1)~=rois{i}(:,2)) & (rois{i}(:,1)~=rois{i}(:,3))));
    cstream_dom_parent_holding_only = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_parent_holding_only(match_index_parent_inhand_only,2) = rois{i}(match_index_parent_inhand_only,1);
    cevent_dom_parent_holding_only = cstream2cevent(cstream_dom_parent_holding_only);

    % record variables
    %delete_variables(sub_list(i),'cstream_vision_dominant-inhand_child-parent');
%     record_additional_variable(sub_list(i),'cstream_vision_dom-parent-inhand_child', cstream_dom_parent_holding_only);
%     record_additional_variable(sub_list(i),'cevent_vision_dom-parent-inhand_child', cevent_dom_parent_holding_only);



    % find matched condition: joint holding
    match_index_child_left_match = union(find((rois{i}(:,2)==rois{i}(:,1)) & (rois{i}(:,4)==rois{i}(:,1))),find((rois{i}(:,2)==rois{i}(:,1)) & (rois{i}(:,5)==rois{i}(:,1))));
    match_index_child_right_match = union(find((rois{i}(:,3)==rois{i}(:,1)) & (rois{i}(:,4)==rois{i}(:,1))),find((rois{i}(:,3)==rois{i}(:,1)) & (rois{i}(:,5)==rois{i}(:,1))));
    %match_index_child_right_match = union(find(abs(rois{i}(:,3)-rois{i}(:,4))==0),find(abs(rois{i}(:,3)-rois{i}(:,5))==0));
    %match_index_joint_holding = find(abs(cstream_dom_child_holding_only(:,2)-rois{i}(:,1))==0 & abs(cstream_dom_parent_holding_only(:,2)-rois{i}(:,1))==0);
    match_index_joint_holding = union(match_index_child_left_match,match_index_child_right_match);
    cstream_dom_joint_holding = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_joint_holding(match_index_joint_holding,2) = rois{i}(match_index_joint_holding,1);
    cevent_dom_joint_holding = cstream2cevent(cstream_dom_joint_holding);

    % record variables
%     record_additional_variable(sub_list(i),'cstream_vision_dom-joint-inhand_child', cstream_dom_joint_holding);
%     record_additional_variable(sub_list(i),'cevent_vision_dom-joint-inhand_child', cevent_dom_joint_holding);


    % find matched condition: not hold by neither
    %match_index_not_inhand = find(rois{i}(:,2)~=rois{i}(:,4) & rois{i}(:,2)~=rois{i}(:,5) & rois{i}(:,3)~=rois{i}(:,4) & rois{i}(:,3)~=rois{i}(:,5));
    %match_index_not_inhand = find(abs(cstream_dom_child_holding_only(:,2)-rois{i}(:,1))~=0 & abs(cstream_dom_parent_holding_only(:,2)-rois{i}(:,1))~=0);
    match_index_not_inhand = find(rois{i}(:,1)~=0 & rois{i}(:,2)~=rois{i}(:,1) & rois{i}(:,3)~=rois{i}(:,1) & rois{i}(:,4)~=rois{i}(:,1) & rois{i}(:,5)~=rois{i}(:,1));
    cstream_dom_not_holding = [roi(:,1) zeros(size(roi,1),1)];
    cstream_dom_not_holding(match_index_not_inhand,2) = rois{i}(match_index_not_inhand,1);
    cevent_dom_not_holding = cstream2cevent(cstream_dom_not_holding);

    % record variables
%     record_additional_variable(sub_list(i),'cstream_vision_dom-not-inhand_child', cstream_dom_not_holding);
%     record_additional_variable(sub_list(i),'cevent_vision_dom-not-inhand_child', cevent_dom_not_holding);


    % find matched condition: dom-mismatch-child-inhand
    mismatch_index_child_left = find(rois{i}(:,2)~=rois{i}(:,1) & rois{i}(:,2)~=0 & rois{i}(:,1)~=0);
    mismatch_index_child_right = find(rois{i}(:,3)~=rois{i}(:,1) & rois{i}(:,3)~=0 & rois{i}(:,1)~=0);
    mismatch_index_child_inhand_dom = union(mismatch_index_child_left,mismatch_index_child_right);
    mismatch_child_inhand_dom = [roi(:,1) zeros(size(roi,1),1)];
    mismatch_child_inhand_dom(mismatch_index_child_inhand_dom,2) = rois{i}(mismatch_index_child_inhand_dom,1);
    cevent_mismatch_child_inhand_dom = cstream2cevent(mismatch_child_inhand_dom);

    
    mismatch_child_inhand_dom_inhand = [roi(:,1) zeros(size(roi,1),1)];

    for ind = 1:length(mismatch_index_child_inhand_dom)
%         disp(ind_child);
%         disp(rois{i}(ind_child,2)~=0);
        if (rois{i}(mismatch_index_child_inhand_dom(ind),2)~=0)
            mismatch_child_inhand_dom_inhand(mismatch_index_child_inhand_dom(ind),2) = rois{i}(mismatch_index_child_inhand_dom(ind),2);
        else
%             fprintf('here%d\n',ind_child);
            mismatch_child_inhand_dom_inhand(mismatch_index_child_inhand_dom(ind),2) = rois{i}(mismatch_index_child_inhand_dom(ind),3);
        end
    end

    cevent_mismatch_child_inhand_dom_inhand = cstream2cevent(mismatch_child_inhand_dom_inhand);

    record_additional_variable(sub_list(i),'cevent_vision_dom-mismatch-child-inhand_child',cevent_mismatch_child_inhand_dom);
    record_additional_variable(sub_list(i),'cevent_vision_child-inhand-mismatch-dom_child',cevent_mismatch_child_inhand_dom_inhand);

%     Cevent_vision_dom-mismatch-child/parent-inhand_child
%     cevent_vision_child/parent-inhand-mismatch-dom_child



    % find matched condition: dom-mismatch-parent-inhand
    mismatch_index_parent_left = find(rois{i}(:,4)~=rois{i}(:,1) & rois{i}(:,4)~=0 & rois{i}(:,1)~=0);
    mismatch_index_parent_right = find(rois{i}(:,5)~=rois{i}(:,1) & rois{i}(:,5)~=0 & rois{i}(:,1)~=0);
    mismatch_index_parent_inhand_dom = union(mismatch_index_parent_left,mismatch_index_parent_right);
    mismatch_parent_inhand_dom = [roi(:,1) zeros(size(roi,1),1)];
    mismatch_parent_inhand_dom(mismatch_index_parent_inhand_dom,2) = rois{i}(mismatch_index_parent_inhand_dom,1);
    cevent_mismatch_parent_inhand_dom = cstream2cevent(mismatch_parent_inhand_dom);

    mismatch_parent_inhand_dom_inhand = [roi(:,1) zeros(size(roi,1),1)];

    for ind = 1:length(mismatch_index_parent_inhand_dom)
        if (rois{i}(mismatch_index_parent_inhand_dom(ind),4)~=0)
            mismatch_parent_inhand_dom_inhand(mismatch_index_parent_inhand_dom(ind),2) = rois{i}(mismatch_index_parent_inhand_dom(ind),4);
        else
            mismatch_parent_inhand_dom_inhand(mismatch_index_parent_inhand_dom(ind),2) = rois{i}(mismatch_index_parent_inhand_dom(ind),5);
        end
    end

    cevent_mismatch_parent_inhand_dom_inhand = cstream2cevent(mismatch_parent_inhand_dom_inhand);

    record_additional_variable(sub_list(i),'cevent_vision_dom-mismatch-parent-inhand_child',cevent_mismatch_parent_inhand_dom);
    record_additional_variable(sub_list(i),'cevent_vision_parent-inhand-mismatch-dom_child',cevent_mismatch_parent_inhand_dom_inhand);

    rois{i}(:,6) = mismatch_child_inhand_dom(:,2);
    rois{i}(:,7) = mismatch_parent_inhand_dom(:,2);
    rois{i}(:,8) = mismatch_child_inhand_dom_inhand(:,2);
    rois{i}(:,9) = mismatch_parent_inhand_dom_inhand(:,2);


    


%     disp(sum(rois{i}(:,1)~=0));
%     disp(sum(cstream_dom_child_holding_only(:,2)~=0) + sum(cstream_dom_parent_holding_only(:,2)~=0) + sum(cstream_dom_joint_holding(:,2)~=0) + sum(cstream_dom_not_holding(:,2)~=0));

end