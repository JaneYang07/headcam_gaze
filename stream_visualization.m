clear;
exp_id = 12;
obj_num = 24;

subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

vars = {'cstream_inhand_left-hand_obj-all_child','cstream_inhand_right-hand_obj-all_child','cstream_vision_size_obj-largest-dominant-child-inhand','cstream_vision_size_obj-largest-dominant_child', 'cstream_eye-vision_largest-dominant-roi_child', 'cstream_eye_roi_child','cstream_vision_size_obj-largest-dominant-parent-inhand','cstream_inhand_right-hand_obj-all_parent','cstream_inhand_left-hand_obj-all_parent','cstream_vision_size_obj-largest-dominant-child-inhand-roi','cstream_vision_size_obj-largest-dominant-parent-inhand-roi'};
labels = {'c_left', 'c_right','c_ha_dom','dominant','roi_dom','c_roi','p_ha_dom','p_right','p_left','c_all','p_all'};
args.window_times_variable = [0 150;150 300;300 450;450 600];
directory = '.';
% note that directory = '.' will save in the current directory
vis_streams_multiwork(subexpIDs, vars, labels, directory, args);