clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

% for i = 1 : length(sub_list)
% %     make cevent/cstream_vision_size_obj-largest-dominant-sustained_1s_child variables
%     make_sustained(sub_list(i), 1);
% end



for i = 1 : length(sub_list)
%     make cevent/cstream_vision_size_obj-largest-dominant-sustained_1s_child variables
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-dominant-sustained_1s_child');
%     delete_variables(sub_list(i),'cevent_vision_size_obj-largest-dominant-sustained_1s_child');
% 
% 
% 
%     delete_variables(sub_list(i),'cevent_vision_size_obj-largest_child');
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest_child');
%     delete_variables(sub_list(i),'cont_vision_size_obj-largest-size_child');
%     
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-child-inhand');
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-parent-inhand');
%     
    delete_variables(sub_list(i),'cevent_eye-vision_largest-roi_child');
    delete_variables(sub_list(i),'cstream_eye-vision_largest-roi_child');
% 
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-dominant_child');
%     delete_variables(sub_list(i),'cevent_vision_size_obj-largest-dominant_child');
%     
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-dominant-parent-inhand');
%     delete_variables(sub_list(i),'cstream_vision_size_obj-largest-dominant-child-inhand');
%     
%     delete_variables(sub_list(i),'cstream_eye-vision_largest-dominant-roi_child');
%     delete_variables(sub_list(i),'cevent_eye-vision_largest-dominant-roi_child');
end

