%%% Latest version of analysis

clear;

exp_id = [15];
obj_num = 10; % 24 objs for exp 12, 10 objs for exp 15

sub_list = find_subjects({'cont_vision_size_obj9_child'},exp_id);

colNames = {'subId','num_frame','num_roi','num_dom','num_overlap_match','num_overlap_mismatch','num_roi_not_dom','num_dom_not_roi','num_not_roi_and_not_dom'};
result_matrix = zeros(0,numel(colNames));



% cevent/cstream_eye-vision_roi-dom-match-state_child
% Roi     	dom  	category
% 1        	1 (match)  1
% 1        	1(mismatch) 2
% 1        	0        	3
% 0        	1        	4
% 0        	0        	5


% For 1-1-match, cevent_eye-vision_roi-dom-match-obj_child
% For 1-1-mismatch-roi, cevent_eye-vision_roi-mismatch-dom-obj_child 
% For 1-1-mismatch-dom, cevent_eye-vision_dom-mismatch-roi-obj_child


for i = 1 : length(sub_list)
    roi = get_variable_by_trial_cat(sub_list(i),'cstream_eye_roi_child');
    dominant = get_variable_by_trial_cat(sub_list(i),'cstream_vision_dominant-obj_child');
    roi_dominant = get_variable_by_trial_cat(sub_list(i),'cstream_eye-vision_roi-dominant_child');


    roi(:,1) = round(roi(:,1),4);
    dominant(:,1) = round(dominant(:,1),4);
    roi_dominant(:,1) = round(roi_dominant(:,1),4);

    roi(isnan(roi(:,2)),2) = 0;
    dominant(isnan(dominant(:,2)),2) = 0;
    roi_dominant(isnan(roi_dominant(:,2)),2) = 0;


    rois{i} = align_streams(roi(:,1),{dominant,roi_dominant});
    state_matrix{i} = [roi(:,1) zeros(size(roi,1),1) zeros(size(roi,1),1) zeros(size(roi,1),1)];
    match_matrix{i} = [roi(:,1) zeros(size(roi,1),1)];
    mismatch_roi_matrix{i} = [roi(:,1) zeros(size(roi,1),1)];
    mismatch_dom_matrix{i} = [roi(:,1) zeros(size(roi,1),1)];
    nonoverlap_roi_matrix{i} = [roi(:,1) zeros(size(roi,1),1)];

    result_matrix(i,1) = sub_list(i);
    % num_frame
    num_frame = length(roi);
    result_matrix(i,2) = num_frame;
    % num_roi
    num_roi = sum(roi(:,2)~=0 & ~isnan(roi(:,2)));
    result_matrix(i,3) = num_roi;
    % num_dom
    num_dom = sum(rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1)));
    result_matrix(i,4) = num_dom;



    % num_overlap_match
    num_match = sum(rois{i}(:,2)~=0 & ~isnan(rois{i}(:,2)));
    result_matrix(i,5) = num_match;
    
    match_index_roi_dom = find(rois{i}(:,2)~=0 & ~isnan(rois{i}(:,2)));
    state_matrix{i}(match_index_roi_dom,2) = 1;
    state_matrix{i}(match_index_roi_dom,3) = 1;
    state_matrix{i}(match_index_roi_dom,4) = 1;

    match_matrix{i}(match_index_roi_dom,2) = rois{i}(match_index_roi_dom,2);
    
    % num_overlap_mismatch
    num_mismatch = size(find(abs(roi(:,2)-rois{i}(:,1))~=0 & roi(:,2)~=0 & ~isnan(roi(:,2)) & rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1))),1);
    result_matrix(i,6) = num_mismatch;

    mismatch_index_roi_dom = find(abs(roi(:,2)-rois{i}(:,1))~=0 & roi(:,2)~=0 & ~isnan(roi(:,2)) & rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1)));
    state_matrix{i}(mismatch_index_roi_dom,2) = 1;
    state_matrix{i}(mismatch_index_roi_dom,3) = 1;
    state_matrix{i}(mismatch_index_roi_dom,4) = 2;

    mismatch_roi_matrix{i}(mismatch_index_roi_dom,2) = roi(mismatch_index_roi_dom,2);
    mismatch_dom_matrix{i}(mismatch_index_roi_dom,2) = rois{i}(mismatch_index_roi_dom,1);

    % num_roi_not_dom
    num_roi_not_dom = size(find((roi(:,2)~=0 & ~isnan(roi(:,2))) & (roi(:,2)-rois{i}(:,1)==roi(:,2) | isnan(abs(roi(:,2)-rois{i}(:,1))))),1);
    result_matrix(i,7) = num_roi_not_dom;

    nonoverlap_index_roi_dom = find((roi(:,2)~=0 & ~isnan(roi(:,2))) & (roi(:,2)-rois{i}(:,1)==roi(:,2) | isnan(abs(roi(:,2)-rois{i}(:,1)))));
    state_matrix{i}(nonoverlap_index_roi_dom,2) = 1;
    state_matrix{i}(nonoverlap_index_roi_dom,3) = 0;
    state_matrix{i}(nonoverlap_index_roi_dom,4) = 3;

    nonoverlap_roi_matrix{i}(nonoverlap_index_roi_dom,2) = roi(nonoverlap_index_roi_dom,2);


    % num_dom_not_roi
    num_dom_not_roi = size(find((rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1))) & (rois{i}(:,1)-roi(:,2)==rois{i}(:,1) | isnan(abs(rois{i}(:,1)-roi(:,2))))),1);
    result_matrix(i,8) = num_dom_not_roi;

    nonoverlap_index_dom_roi = find((rois{i}(:,1)~=0 & ~isnan(rois{i}(:,1))) & (rois{i}(:,1)-roi(:,2)==rois{i}(:,1) | isnan(abs(rois{i}(:,1)-roi(:,2)))));
    state_matrix{i}(nonoverlap_index_dom_roi,2) = 0;
    state_matrix{i}(nonoverlap_index_dom_roi,3) = 1;
    state_matrix{i}(nonoverlap_index_dom_roi,4) = 4;

    % num_not_roi_and_not_dom
    num_not_roi_and_not_dom = size(find((abs(roi(:,2)-rois{i}(:,1))==0 | isnan(abs(roi(:,2)-rois{i}(:,1)))) & (roi(:,2)==0 | isnan(roi(:,2))) & (rois{i}(:,1)==0 | isnan(rois{i}(:,1)))),1);
    result_matrix(i,9) = num_not_roi_and_not_dom;

    nonoverlap_index_both_not = find((abs(roi(:,2)-rois{i}(:,1))==0 | isnan(abs(roi(:,2)-rois{i}(:,1)))) & (roi(:,2)==0 | isnan(roi(:,2))) & (rois{i}(:,1)==0 | isnan(rois{i}(:,1))));
    state_matrix{i}(nonoverlap_index_both_not,2) = 0;
    state_matrix{i}(nonoverlap_index_both_not,3) = 0;
    state_matrix{i}(nonoverlap_index_both_not,4) = 5;

    cstream_state = [state_matrix{i}(:,1) state_matrix{i}(:,4)];
    cevent_state = cstream2cevent(cstream_state);

    cevent_roi_no_dom = cstream2cevent(nonoverlap_roi_matrix{i});
%     delete_variables('cstream_eye-vision_roi-no-dom-obj_child');
    record_additional_variable(sub_list(i),'cstream_eye-vision_roi-no-dom-obj_child',nonoverlap_roi_matrix{i});
    record_additional_variable(sub_list(i),'cevent_eye-vision_roi-no-dom-obj_child',cevent_roi_no_dom);
    record_additional_variable(sub_list(i),'cstream_eye-vision_roi-dom-match-state_child',cstream_state);
    record_additional_variable(sub_list(i),'cevent_eye-vision_roi-dom-match-state_child',cevent_state);
    cevent_match_roi_dom = cstream2cevent(match_matrix{i});
    cevent_mismatch_roi = cstream2cevent(mismatch_roi_matrix{i});
    cevent_mismatch_dom = cstream2cevent(mismatch_dom_matrix{i});
    record_additional_variable(sub_list(i),'cevent_eye-vision_roi-dom-match-obj_child',cevent_match_roi_dom);
    record_additional_variable(sub_list(i),'cevent_eye-vision_roi-mismatch-dom-obj_child',cevent_mismatch_roi);
    record_additional_variable(sub_list(i),'cevent_eye-vision_dom-mismatch-roi-obj_child',cevent_mismatch_dom);
end

result_table = array2table(result_matrix,'VariableNames',colNames);
writetable(result_table,'result_table_exp15.csv');




