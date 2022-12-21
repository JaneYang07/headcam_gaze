clear;


profile_input.sub_list = setxor(list_subjects(12),1229);
%profile_input.sub_list = [1201 1202];



num_obj = 24;

profile_input.cevent_name = 'cevent_eye_roi_sustained-3s_child';
%profile_input.cevent_name = 'cevent_eye_roi_child';
profile_input.whence = 'start';
profile_input.interval = [-3 10];
profile_input.sample_rate = 0.03334;
 

var_name = {};
for i = 1 : num_obj
    var_name{end+1} = sprintf('cont_vision_size_obj%d_child',i);
end

profile_input.var_name = var_name;
profile_input.var_category = [1:num_obj];
profile_input.cevent_category = [1:num_obj];
profile_input.groupid_matrix = ones(num_obj) * 2 + diag(-ones(num_obj,1));

profile_input.groupid_label = {'target', 'non-target'};
   
  
profile_data = temporal_profile_generate_by_cevent(profile_input);
temporal_profile_save_csv_plot(profile_data, '.');
