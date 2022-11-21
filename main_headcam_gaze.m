clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj1_child'},[exp_id]);
%sub_list = [1201 1202];

for i = 1 : length(sub_list)
    tmp1 = get_variable_by_trial_cat(sub_list(i),'cstream_vision_size_obj-largest_child');
    tmp2 = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');


    if (size(tmp1,1) == size(tmp2,1))
        rois{i}(:,1) = tmp1(:,2);
        rois{i}(:,2) = tmp2(:,2);

        %disp([rois{i}(:,1),rois{i}(:,2)]);
        index1 = find(abs(rois{i}(:,1)-rois{i}(:,2))==0);
        index2 = find(rois{i}(:,1)>0);
        match_ratio(i) = size(index1,1)/size(index2,1);
    end
    %rate = size(find((rois{i}(:,1)-rois{i}(:,1))==0))/size(tmp,1);
    %disp(rate);

    
end
% 
% disp(size(match_ratio,2));