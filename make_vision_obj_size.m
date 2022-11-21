clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_obj1_child'},[12]);
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
    [large_size large_objs] = max(obj_size{i},[],2);
    data1 = [tmp(:,1) large_objs];
    record_additional_variable(sub_list(i),'cstream_vision_size_obj-largest_child', data1);
    cevent_data1 = cstream2cevent(data1);
    record_additional_variable(sub_list(i),'cevent_vision_size_obj-largest_child', cevent_data1);
    data2 = [tmp(:,1) large_size];
    record_additional_variable(sub_list(i),'cont_vision_size_obj-largest-size_child', data2);

end

disp(max(obj_size{1},[],2));


