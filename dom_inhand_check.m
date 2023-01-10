c_inhand = get_variable_by_trial_cat(1510,'cstream_vision_dom-child-inhand_child');
p_inhand = get_variable_by_trial_cat(1510,'cstream_vision_dom-parent-inhand_child');
joint_inhand = get_variable_by_trial_cat(1510,'cstream_vision_dom-joint-inhand_child');
not_inhand = get_variable_by_trial_cat(1510,'cstream_vision_dom-not-inhand_child');

dom = get_variable_by_trial_cat(1510,'cstream_vision_dominant-obj_child');
num_dom = sum(dom(:,2)~=0);
num_added = sum(c_inhand(:,2)~=0) + sum(p_inhand(:,2)~=0) + sum(joint_inhand(:,2)~=0) + sum(not_inhand(:,2)~=0);