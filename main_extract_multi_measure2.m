clear; 

exp_list = [12];  
num_obj = 24;
%window_size = 3;
flag = 1; %1--target ; 2 -- all


if flag == 1
    type = 'target';
else
    type = 'all';
end


for exp = 1 : length(exp_list)
        var_list = {'cevent_eye_roi_child', 'cevent_eye_roi_parent','cont_vision_size_obj#_child','cevent_inhand_child','cevent_inhand_parent'};
        subexpIDs = [exp_list(exp)]; % this can also be a list of experiments
        %subexpIDs = [ 1201 1202]; 
        %subexpIDs = [1502 1503 1504 1508 1510 1513 1514 1520 1521 1522 1524 1525 1526 1527 1529 1531 1532 1534 1535 1536 1537];
       
        filename = sprintf('dom-mismatch-parent-inhand_by_roi_%s_exp%d.csv', type, subexpIDs);
        %args.cevent_name = 'cevent_eye-vision_roi-dom-match-obj_child'; % these are the windows of time, or instances, from which data will be extracted and measured
        %args.cevent_name = 'cevent_vision_dom-not-inhand_child'; % these are the windows of time, or instances, from which data will be extracted and measured
        args.cevent_name = 'cevent_vision_dom-mismatch-parent-inhand_child'; 
        %args.cevent_name = 'cevent_speech_known-words';
        %args.cevent_name = 'cevent_speech_naming_local-id';
        args.cevent_values = 1:num_obj; % which categories in cevent_name you wish to use
        %args.whence = 'start'; % the point of reference, which is either the 'start' of the cevent (onset), or the 'end' of the cevent (offset)
        %args.interval = [0 0.5]
       
        %target vs. others
        if flag == 1
            args.label_matrix = ones(num_obj) * 2 + diag(-ones(num_obj,1));
            args.label_names = {'target', 'other'};
        else
            for i = 1 : num_obj
            args.label_matrix(i,:) = args.cevent_values;
            end
            args.label_names = arrayfun(@num2str, [1:num_obj], 'UniformOutput', 0);
        end
       
        %args.cevent_measures = 'individual_prop';
        % we can now name those two categories as 'target' and 'other' -if
        % there are 2 distinct numbers in label_matrix, there should be 2
        % distinct names in label_names
       
        %args.whence = 'end'; % the point of reference, which is either the 'start' of the cevent (onset), or the 'end' of the cevent (offset)
        %args.interval = [0 2]; % window_size]
       
      % args.within_ranges = 0;

        %args.cevent_measures = 'individual_prop';
        %args.cont_measures = 'individual_mean';
        % one can specify the measures they wish for each data type
        % individual_prop_by_cat will output data for each object
        % individual_prop will will average the data across objects
       
        extract_multi_measures(var_list, subexpIDs, filename, args);
end;