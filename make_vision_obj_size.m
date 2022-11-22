clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
%sub_list = [1201 1202];

for i = 1 : length(sub_list)
    for obj_id = 1 : obj_num
        tmp = get_variable(sub_list(i),sprintf('cont_vision_size_obj%d_child',obj_id));
        obj_size{i}(obj_id,:) = tmp(:,2);
    end

    % find the largest object in each frame
    % save it as a cstream variable
    large_size = [];
    large_objs = [];
    data1 = [];
    data2 = [];
    [large_size large_objs] = max(obj_size{i},[],1);
%      data1 = [tmp(:,1) large_objs];
%     record_additional_variable(sub_list(i),'cstream_vision_size_obj-largest_child', data1);
%      cevent_data1 = cstream2cevent(data1);
%     record_additional_variable(sub_list(i),'cevent_vision_size_obj-largest_child', cevent_data1);
%      data2 = [tmp(:,1) large_size];
%     record_additional_variable(sub_list(i),'cont_vision_size_obj-largest-size_child', data2);


    %%% TODO: generate an aligned version of obj-largest and compare it
    %%% with original obj-largest in vis_streams

    % find the instances where the largest object is also in hand of
    % child/parent
    % load all relevant variables
    roi = get_variable(sub_list(i),'cstream_eye_roi_child');
    cstream_large_objs = get_variable(sub_list(i),'cstream_vision_size_obj-largest_child');
    
    inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    % align variables with roi's timestamp
    rois{i} = align_streams(roi(:,1), {cstream_large_objs,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});

    % find matched condition
    match_index_child_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,2))==0),find(abs(rois{i}(:,1)-rois{i}(:,3))==0));
    match_index_parent_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,4))==0),find(abs(rois{i}(:,1)-rois{i}(:,5))==0));

    % record instances when it's both inhand and it's the largest object
    large_objs_child_inhand = [roi(:,1) zeros(size(roi,1),1)];
    large_objs_parent_inhand = [roi(:,1) zeros(size(roi,1),1)];

    large_objs_child_inhand(match_index_child_inhand,2) = rois{i}(match_index_child_inhand,1);
    large_objs_parent_inhand(match_index_parent_inhand,2) = rois{i}(match_index_parent_inhand,1);
    
    record_additional_variable(sub_list(i),'cstream_vision_size_obj-largest-child-inhand', large_objs_child_inhand);
    record_additional_variable(sub_list(i),'cstream_vision_size_obj-largest-parent-inhand', large_objs_parent_inhand);
end


