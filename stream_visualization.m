% clear;
% exp_id = 15;
% obj_num = 10;
% 
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cstream_inhand_left-hand_obj-all_child','cstream_inhand_right-hand_obj-all_child','cstream_vision_size_obj-largest-dominant-child-inhand','cstream_vision_size_obj-largest-dominant_child', 'cstream_eye-vision_largest-dominant-roi_child', 'cstream_eye_roi_child','cstream_vision_size_obj-largest-dominant-parent-inhand','cstream_inhand_right-hand_obj-all_parent','cstream_inhand_left-hand_obj-all_parent'};
% labels = {'c_left', 'c_right','c_ha_dom','dominant','roi_dom','c_roi','p_ha_dom','p_right','p_left'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);
% 


% clear;
% exp_id = 12;
% obj_num = 24;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cstream_vision_dom-child-inhand_child','cstream_vision_dom-parent-inhand_child','cstream_vision_dom-joint-inhand_child','cstream_vision_dom-not-inhand_child','cstream_vision_dominant-obj_child','cstream_inhand_right-hand_obj-all_parent','cstream_inhand_left-hand_obj-all_parent','cstream_inhand_right-hand_obj-all_child','cstream_inhand_left-hand_obj-all_child'};
% labels = {'c_inhand', 'p_inhand','joint_inhand','not_inhand','dom','p_r','p_l','c_r','c_l'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);



% clear;
% exp_id = 12;
% obj_num = 24;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_vision_dom-child-inhand_child','cevent_vision_dom-parent-inhand_child','cevent_vision_dom-joint-inhand_child','cevent_vision_dom-not-inhand_child','cevent_vision_dominant-obj_child','cevent_inhand_right-hand_obj-all_parent','cevent_inhand_left-hand_obj-all_parent','cevent_inhand_right-hand_obj-all_child','cevent_inhand_left-hand_obj-all_child'};
% labels = {'c_inhand', 'p_inhand','joint_inhand','not_inhand','dom','p_r','p_l','c_r','c_l'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);


clear;
exp_id = 12;
obj_num = 24;
subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

vars = {'cstream_vision_dom-not-inhand_child','cstream_vision_dominant-obj_child','cevent_vision_child-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-child-inhand_child','cevent_vision_parent-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-parent-inhand_child','cstream_inhand_right-hand_obj-all_parent','cstream_inhand_left-hand_obj-all_parent','cstream_inhand_right-hand_obj-all_child','cstream_inhand_left-hand_obj-all_child'};
labels = {'not_inhand', 'dom','c_dom_hand','c_hand_dom','p_dom_hand','p_hand_dom','p_right','p_left','c_right','c_left'};
args.window_times_variable = [0 150;150 300;300 450;450 600];
directory = '.';
% note that directory = '.' will save in the current directory
vis_streams_multiwork(subexpIDs, vars, labels, directory, args);
