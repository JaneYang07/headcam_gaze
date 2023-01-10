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


% clear;
% exp_id = 15;
% obj_num = 10;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cstream_vision_largest-obj_child','cstream_vision_largest-obj_parent','cstream_eye_joint-attend_both','cstream_vision_dominant-obj_child','cstream_vision_dominant-obj_parent'};
% labels = {'c_large','p_large','joint','c_dom','p_dom'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);

% clear;
% exp_id = 15;
% obj_num = 10;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_vision_largest-obj_child','cevent_vision_largest-obj_parent','cevent_eye_joint-attend_both','cevent_vision_dominant-obj_child','cevent_vision_dominant-obj_parent'};
% labels = {'c_large','p_large','joint','c_dom','p_dom'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);


% clear;
% exp_id = 12;
% obj_num = 24;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_vision_dom-not-inhand_child','cevent_vision_dominant-obj_child','cevent_vision_child-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-child-inhand_child','cevent_vision_parent-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-parent-inhand_child','cevent_inhand_right-hand_obj-all_parent','cevent_inhand_left-hand_obj-all_parent','cevent_inhand_right-hand_obj-all_child','cevent_inhand_left-hand_obj-all_child'};
% labels = {'not_inhand', 'dom','c_h_d','c_d_h','p_h_d','p_d_h','p_right','p_left','c_right','c_left'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);
% 
% clear;
% exp_id = 15;
% obj_num = 10;
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_vision_dom-not-inhand_child','cevent_vision_dominant-obj_child','cevent_vision_child-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-child-inhand_child','cevent_vision_parent-inhand-mismatch-dom_child','cevent_vision_dom-mismatch-parent-inhand_child','cevent_inhand_right-hand_obj-all_parent','cevent_inhand_left-hand_obj-all_parent','cevent_inhand_right-hand_obj-all_child','cevent_inhand_left-hand_obj-all_child'};
% labels = {'not_inhand', 'dom','c_h_d','c_d_h','p_h_d','p_d_h','p_right','p_left','c_right','c_left'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);


%%% dom-inhand match/mismatch

% cevent/cstream_vision_dom-parent/child-inhand_child
% cevent/cstream_vision_dom-joint-inhand_child
% cevent/cstream_vision_dom-not-inhand_child

clear;
exp_id = 12;
obj_num = 24;
subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

vars = {'cevent_vision_dom-child-inhand_child','cevent_vision_dom-parent-inhand_child','cevent_vision_dom-joint-inhand_child','cevent_vision_dom-not-inhand_child','cevent_vision_dominant-obj_child','cevent_inhand_right-hand_obj-all_parent','cevent_inhand_left-hand_obj-all_parent','cevent_inhand_right-hand_obj-all_child','cevent_inhand_left-hand_obj-all_child'};
labels = {'c_inhand', 'p_inhand','joint-hand','not-hand','dom','p_right','p_left','c_right','c_left'};
args.window_times_variable = [0 150;150 300;300 450;450 600];
directory = '.';
% note that directory = '.' will save in the current directory
vis_streams_multiwork(subexpIDs, vars, labels, directory, args);

clear;
exp_id = 15;
obj_num = 10;
subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

vars = {'cevent_vision_dom-child-inhand_child','cevent_vision_dom-parent-inhand_child','cevent_vision_dom-joint-inhand_child','cevent_vision_dom-not-inhand_child','cevent_vision_dominant-obj_child','cevent_inhand_right-hand_obj-all_parent','cevent_inhand_left-hand_obj-all_parent','cevent_inhand_right-hand_obj-all_child','cevent_inhand_left-hand_obj-all_child'};
labels = {'c_inhand', 'p_inhand','joint-hand','not-hand','dom','p_right','p_left','c_right','c_left'};
args.window_times_variable = [0 150;150 300;300 450;450 600];
directory = '.';
% note that directory = '.' will save in the current directory
vis_streams_multiwork(subexpIDs, vars, labels, directory, args);

% clear;
% exp_id = 12;
% obj_num = 24;
% 
% sub_list_1 = find_subjects({'cont_vision_size_obj9_parent'},[exp_id]);
% sub_list_2 = find_subjects({'cstream_eye_joint-attend_both'},[exp_id]);
% subexpIDs = intersect(sub_list_1,sub_list_2);
% 
% vars = {'cstream_vision_largest-obj_child','cstream_vision_largest-obj_parent','cstream_vision_joint-largest-obj_both','cstream_eye_joint-attend_both','cstream_vision_dominant-obj_child','cstream_vision_dominant-obj_parent'};
% labels = {'c_large','p_large','joint_large','joint','c_dom','p_dom'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);
% 
% clear;
% exp_id = 15;
% obj_num = 10;
% 
% sub_list_1 = find_subjects({'cont_vision_size_obj9_parent'},[exp_id]);
% sub_list_2 = find_subjects({'cstream_eye_joint-attend_both'},[exp_id]);
% subexpIDs = intersect(sub_list_1,sub_list_2);
% 
% vars = {'cstream_vision_largest-obj_child','cstream_vision_largest-obj_parent','cstream_vision_joint-largest-obj_both','cstream_eye_joint-attend_both','cstream_vision_dominant-obj_child','cstream_vision_dominant-obj_parent'};
% labels = {'c_large','p_large','joint_large','joint','c_dom','p_dom'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);


% clear;
% exp_id = 15;
% obj_num = 10;
% 
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_eye_roi_child','cevent_vision_dominant-obj_child','cevent_eye-vision_roi-dom-match-state_child','cevent_eye-vision_roi-dom-match-obj_child','cevent_eye-vision_roi-mismatch-dom-obj_child','cevent_eye-vision_dom-mismatch-roi-obj_child'};
% labels = {'roi','dom','match-state','match-obj','mismatch-r','mismatch-d'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);

% clear;
% exp_id = 12;
% obj_num = 24;
% 
% subexpIDs = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);
% 
% vars = {'cevent_eye_roi_child','cevent_vision_dominant-obj_child','cevent_eye-vision_roi-dom-match-state_child','cevent_eye-vision_roi-dom-match-obj_child','cevent_eye-vision_roi-mismatch-dom-obj_child','cevent_eye-vision_dom-mismatch-roi-obj_child'};
% labels = {'roi','dom','match-state','match-obj','mismatch-r','mismatch-d'};
% args.window_times_variable = [0 150;150 300;300 450;450 600];
% directory = '.';
% % note that directory = '.' will save in the current directory
% vis_streams_multiwork(subexpIDs, vars, labels, directory, args);