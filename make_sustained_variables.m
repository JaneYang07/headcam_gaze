clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

for i = 1 : length(sub_list)
    % make cevent/cstream_vision_size_obj-largest-dominant-sustaine_1s_child variables
    make_sustained(sub_list(i), 1);
end