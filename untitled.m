clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
sub_list = [1202 1203];

% for i = 1 : length(sub_list)
%     cstream_large_objs = get_variable(sub_list(i),'cstream_vision_size_obj-largest_child');
%     roi = get_variable(sub_list(i),'cstream_eye_roi_child');
% 
% 
%     inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
%     inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
%     inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
%     inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');
% 
% 
% 
% end



subexpIDs = [1201 1202 1203];
vars = {'cstream_eye_roi_child', 'cstream_vision_size_obj-largest_child', 'cstream_inhand_left-hand_obj-all_child'};
labels = {'cseye', 'csobj', 'child_left_inhand'};
args.window_times_variable = [0 200;200 400;400 600;];
directory = '.';
% note that directory = '.' will save in the current directory
vis_streams_multiwork(subexpIDs, vars, labels, directory, args);