addpath('~/dev/libsvm-3.23/matlab')
disp('path added')
[X, y, X_cv, y_cv, X_test, y_test] = create_data_sets();
disp('data loaded')
C_values = [0.3, 1, 3]
for i = 1:length(C_values)
    flags = sprintf('-t 2 -h 0 -c %f', C_values(i));
    disp(flags)
    model = svmtrain(y, X, flags);
    disp('training done')
    tic()
    [predicted_label, accuracy, decision_values] = svmpredict(y_cv, X_cv, model);
    toc()
end