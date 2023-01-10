clear; 

profile_input.sub_list = list_subjects(12); 
profile_input.sub_list = [ 1201]; 

num_obj = 24;

profile_input.cevent_name = 'cevent_eye_roi_child';
profile_input.whence = 'start';
profile_input.interval = [-5 5];
profile_input.sample_rate = 0.03334;
 
profile_input.var_name = 'cstream_inhand_both-hand_child';
profile_input.var_category = [1:num_obj];
profile_input.cevent_category = [1:num_obj];
profile_input.groupid_matrix = ones(num_obj) * 2 + diag(-ones(num_obj,1)); 

profile_input.groupid_label = {'target', 'non-target'};
   
profile_data = temporal_profile_generate_by_cevent(profile_input);
temporal_profile_save_csv_plot(profile_data, '.');