clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_parent'},[exp_id]);

for i = 1 : length(sub_list)
    for obj_id = 1 : obj_num
        tmp = get_variable(sub_list(i),sprintf('cont_vision_size_obj%d_parent',obj_id));
        obj_size{i}(:,obj_id) = tmp(:,2);
    end

    % find the largest object in each frame
    % save it as a cstream variable
    large_size = []; large_objs = []; data1 = []; data2 = [];
    [large_size, large_objs] = max(obj_size{i},[],2);
    data1 = [tmp(:,1) large_objs];
    record_additional_variable(sub_list(i),'cstream_vision_largest-obj_parent', data1);
    cevent_data1 = cstream2cevent(data1);
    record_additional_variable(sub_list(i),'cevent_vision_largest-obj_parent', cevent_data1);
    data2 = [tmp(:,1) large_size];
    record_additional_variable(sub_list(i),'cont_vision_largest-size_parent', data2);

    %%% find the dominant object in each frame, 0 if none
    abs_threshold = 0.05; relative_threshold = 0.025;
    largest_objs = []; largest_objs_size = []; second_largest_objs = []; second_largest_objs_size = [];
    sorted_objs = []; sorted_size = [];
    [sorted_size, sorted_objs] = sort(obj_size{i},2,'descend','MissingPlacement','last');



    largest_objs = sorted_objs(:,1);
    largest_objs_size = sorted_size(:,1);
    second_largest_objs = sorted_objs(:,2);
    second_largest_objs_size = sorted_size(:,2);
    dominant_objs = largest_objs; dominant_objs_size = largest_objs_size;
    data3 = [];

    for j = 1 : length(largest_objs_size)
        if largest_objs_size(j) <= abs_threshold || isnan(largest_objs_size(j)) || largest_objs_size(j)-second_largest_objs_size(j) < relative_threshold
            dominant_objs(j) = 0;
        end
    end

    data3 = [tmp(:,1) dominant_objs];
    record_additional_variable(sub_list(i),'cstream_vision_dominant-obj_parent', data3);
    cevent_data3 = cstream2cevent(data3);
    record_additional_variable(sub_list(i),'cevent_vision_dominant-obj_parent', cevent_data3);
end