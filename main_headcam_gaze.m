clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

for i = 1 : length(sub_list)
    tmp1 = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest_child');
    tmp2 = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    inhand1 = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand2 = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand3 = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand4 = get_variable_by_trial_cat(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    rois{i} = align_streams(tmp2(:,1),{tmp1,tmp2,inhand1,inhand2,inhand3,inhand4});

    index1 = find(abs(rois{i}(:,1)-rois{i}(:,2))==0);
    index2 = find(rois{i}(:,2)>0);
    match_ratio(i,1) = size(index1,1)/size(index2,1);

    % match conditioned on child
    index3 = find(abs(rois{i}(:,1)-rois{i}(:,3))==0);
    index4 = find(abs(rois{i}(:,1)-rois{i}(:,4))==0);
    index_child_inhand = union(index3,index4);

    index1 = find(abs(rois{i}(index_child_inhand,1)-rois{i}(index_child_inhand,2))==0);
    index2 = find(rois{i}(index_child_inhand,2)>0);
    match_ratio(i,2) = size(index1,1)/size(index2,1);


    % match conditioned on parent
    index5 = find(abs(rois{i}(:,1)-rois{i}(:,5))==0);
    index6 = find(abs(rois{i}(:,1)-rois{i}(:,6))==0);
    index_parent_inhand = union(index5,index6);

    index1 = find(abs(rois{i}(index_parent_inhand,1)-rois{i}(index_parent_inhand,2))==0);
    index2 = find(rois{i}(index_parent_inhand,2)>0);
    match_ratio(i,3) = size(index1,1)/size(index2,1);
end

%disp(match_ratio);