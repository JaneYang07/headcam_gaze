clear;
exp_id = 12;
obj_num = 24;

sub_list = find_subjects({'cont_vision_size_obj9_child'},[exp_id]);

for i = 1 : length(sub_list)
    for obj_id = 1 : obj_num
        tmp = get_variable(sub_list(i),sprintf('cont_vision_size_obj%d_child',obj_id));
        obj_size{i}(:,obj_id) = tmp(:,2);
    end

    % find the largest object in each frame
    % save it as a cstream variable
    large_size = []; large_objs = []; data1 = []; data2 = [];
    [large_size, large_objs] = max(obj_size{i},[],2);
    data1 = [tmp(:,1) large_objs];
%     record_additional_variable(sub_list(i),'cstream_vision_largest-obj_child', data1);
    cevent_data1 = cstream2cevent(data1);
%     record_additional_variable(sub_list(i),'cevent_vision_largest-obj_child', cevent_data1);
    data2 = [tmp(:,1) large_size];
%     record_additional_variable(sub_list(i),'cont_vision_largest-size_child', data2);

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
%     record_additional_variable(sub_list(i),'cstream_vision_dominant-obj_child', data3);
    cevent_data3 = cstream2cevent(data3);
%     record_additional_variable(sub_list(i),'cevent_vision_dominant-obj_child', cevent_data3);


    %%% MAKE DOMINANT VARIABLES

    % find the instances where the dominant object is also in hand of
    % child/parent
    % load all relevant variables
    roi = get_variable(sub_list(i),'cstream_eye_roi_child');
    cstream_dominant_objs = get_variable(sub_list(i),'cstream_vision_dominant-obj_child');
    
    inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
    inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
    inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
    inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');

    % align variables with roi's timestamp
    rois{i} = align_streams(roi(:,1), {cstream_dominant_objs,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});

    % find matched condition
    match_index_child_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,2))==0),find(abs(rois{i}(:,1)-rois{i}(:,3))==0));
    match_index_parent_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,4))==0),find(abs(rois{i}(:,1)-rois{i}(:,5))==0));

    % record instances when it's both inhand and it's the dominant object
    dominant_objs_child_inhand = [roi(:,1) zeros(size(roi,1),1)];
    dominant_objs_parent_inhand = [roi(:,1) zeros(size(roi,1),1)];

    dominant_objs_child_inhand(match_index_child_inhand,2) = rois{i}(match_index_child_inhand,1);
    dominant_objs_parent_inhand(match_index_parent_inhand,2) = rois{i}(match_index_parent_inhand,1);
    
%     record_additional_variable(sub_list(i),'cstream_vision_dominant-inhand_child-child', dominant_objs_child_inhand);
%     record_additional_variable(sub_list(i),'cstream_vision_dominant-inhand_child-parent', dominant_objs_parent_inhand);

    % find matched condition: roi & dominant obj
    match_index_child_roi = find(abs(roi(:,2)-rois{i}(:,1))==0);
    dominant_objs_child_roi = [roi(:,1) zeros(size(roi,1),1)];
    dominant_objs_child_roi(match_index_child_roi,2) = rois{i}(match_index_child_roi,1);

%     record_additional_variable(sub_list(i),'cstream_eye-vision_roi-dominant_child', dominant_objs_child_roi);
    cevent_data1 = cstream2cevent(dominant_objs_child_roi);
%     record_additional_variable(sub_list(i),'cevent_eye-vision_roi-dominant_child', cevent_data1);

    % make cevent/cstream_vision_size_obj-largest-dominant-sustained_1s_child variables
%     make_sustained(sub_list(i), 1);





























    % make cevent/cstream_eye-vision_roi-size-rank_child variables
%     roi_size_rank = [roi(:,1) zeros(size(roi,1),1)];
% 
% 
% 
% 
%     for frame_ind = 1 : length(sorted_size)
%         sorted_objs(frame_ind,isnan(sorted_size(frame_ind,:)))=0;
%     end
% 
%     tmp = get_variable(sub_list(i),sprintf('cont_vision_size_obj9_child'));
%     sorted_objs_with_time = [tmp(:,1) sorted_objs];
%     roi(:,1) = round(roi(:,1),4);
%     sorted_objs_with_time(:,1) = round(sorted_objs_with_time(:,1),4);
%     [~,ii] = ismember(roi(:,1),sorted_objs_with_time(:,1));
%     disp(ii);
% 
% 
% 
% 
% 
% 
% 
%     %%% MAKE LARGEST VARIABLES
% 
%     % find the instances where the dominant object is also in hand of
%     % child/parent
%     % load all relevant variables
%     roi = get_variable(sub_list(i),'cstream_eye_roi_child');
%     cstream_largest_objs = get_variable(sub_list(i),'cstream_vision_largest-obj_child');
%     
%     inhand_child_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_child');
%     inhand_child_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_child');
%     inhand_parent_left = get_variable(sub_list(i),'cstream_inhand_left-hand_obj-all_parent');
%     inhand_parent_right = get_variable(sub_list(i),'cstream_inhand_right-hand_obj-all_parent');
% 
%     % align variables with roi's timestamp
%     rois{i} = align_streams(roi(:,1), {cstream_largest_objs,inhand_child_left,inhand_child_right,inhand_parent_left,inhand_parent_right});
% 
%     % find matched condition
%     match_index_child_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,2))==0),find(abs(rois{i}(:,1)-rois{i}(:,3))==0));
%     match_index_parent_inhand = union(find(abs(rois{i}(:,1)-rois{i}(:,4))==0),find(abs(rois{i}(:,1)-rois{i}(:,5))==0));
% 
%     % record instances when it's both inhand and it's the dominant object
%     largest_objs_child_inhand = [roi(:,1) zeros(size(roi,1),1)];
%     largest_objs_parent_inhand = [roi(:,1) zeros(size(roi,1),1)];
% 
%     largest_objs_child_inhand(match_index_child_inhand,2) = rois{i}(match_index_child_inhand,1);
%     largest_objs_parent_inhand(match_index_parent_inhand,2) = rois{i}(match_index_parent_inhand,1);
%     
% %     record_additional_variable(sub_list(i),'cstream_vision_largest-inhand_child-child', largest_objs_child_inhand);
% %     record_additional_variable(sub_list(i),'cstream_vision_largest-inhand_child-parent', largest_objs_parent_inhand);
% 
%     % find matched condition: roi & dominant obj
%     match_index_child_roi = find(abs(roi(:,2)-rois{i}(:,1))==0);
%     largest_objs_child_roi = [roi(:,1) zeros(size(roi,1),1)];
%     largest_objs_child_roi(match_index_child_roi,2) = rois{i}(match_index_child_roi,1);
% 
% %     record_additional_variable(sub_list(i),'cstream_eye-vision_roi-largest_child', largest_objs_child_roi);
%     cevent_data1 = cstream2cevent(dominant_objs_child_roi);
% %     record_additional_variable(sub_list(i),'cevent_eye-vision_roi-largest_child', largest_objs_child_roi);
end