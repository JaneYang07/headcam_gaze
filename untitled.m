clear;
exp_id = 15;
obj_num = 10;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

for i = 1 : length(sub_list)
    for obj_id = 1 : obj_num
        tmp = get_variable(sub_list(i),sprintf('cont_vision_size_obj%d_child',obj_id));
        obj_size{i}(:,obj_id) = tmp(:,2);
    end   



    % find the largest object in each frame
    % save it as a cstream variable
    large_size = []; large_objs = []; data1 = []; data2 = [];
    [large_size, large_objs] = max(obj_size{i},[],2);
    data1 = [tmp(:,1) large_objs];
%     record_additional_variable(sub_list(i),'cstream_vision_size_obj-largest_child', data1);
     cevent_data1 = cstream2cevent(data1);
%     record_additional_variable(sub_list(i),'cevent_vision_size_obj-largest_child', cevent_data1);
     data2 = [tmp(:,1) large_size];
%     record_additional_variable(sub_list(i),'cont_vision_size_obj-largest-size_child', data2);

    inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    %%% MAKE SECONDARY LARGEST VARIABLES

    % find the instances where the dominant object is also in hand of
    % child/parent
    % load all relevant variables
    roi = get_variable(sub_list(i),'cstream_eye_roi_child');


    rois{i} = align_streams(roi(:,1),{data1,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});

end