% Demo for Edge Boxes (please see readme.txt first).

%% load pre-trained edge detection model and set opts (see edgesDemo.m)
model=load('models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

%% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = .65;     % step size of sliding window search
opts.beta  = .50;     % nms threshold for object proposals
opts.minScore = .1;  % min score of boxes to detect
opts.maxBoxes = 1e2;  % max number of boxes to detect

%% detect Edge Box bounding box proposals (see edgeBoxes.m)
files=dir('/media/data/Datasets/coco/coco_train2014/*.jpg');
for ind=1:size(files,1)
    imfile=fullfile(files(ind).folder, files(ind).name);
    disp(imfile);
    I = imread(imfile);
    bbs=edgeBoxes(I,model,opts);

    %% show evaluation results (using pre-defined or interactive boxes)
    h=figure();
    imshow(I);
    for i=1:size(bbs,1)
        rectangle('Position',bbs(i,1:4))
    end
    waitfor(h)
end