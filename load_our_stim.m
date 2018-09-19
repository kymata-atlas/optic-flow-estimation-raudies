function ImageSeq = load_our_stim()

    total_trials = 1;%400;
    total_frames = 15;%40;
    
    [w, h, ~] = size(imread(filename_from_trial_and_frame(1, 1)));
    
    % Preallocate
    ImageSeq = zeros(w, h, total_trials * total_frames);
    
    frame_count = 1;
    for trial = 1:total_trials
        for frame = 1:total_frames
            image_path = filename_from_trial_and_frame(trial, frame);
            frame_image = imread(image_path);
            lab_image = rgb2lab(frame_image);
            luminocity = lab_image(:, :, 1);
            ImageSeq(:, :, frame_count) = luminocity;
            
        frame_count = frame_count + 1;
        end%for frame
    end%for trial
end%function

function filename = filename_from_trial_and_frame(trial, frame)
    base_dir = '/Users/cai/Box Sync/Kymata/KYMATA-visual-stimuli-dataset-3_01/video_stimuli_trials';
    filename = fullfile(base_dir, sprintf('trial_%03d', trial), sprintf('frame%02d.png', frame));
end