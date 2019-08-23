function [X, y, X_cv, y_cv, X_test, y_test] = create_data_sets()

load('email_data.mat')
% split ham mails into cv, test and train parts
ham_cv = ham_data(1 : 1110, :);
ham_test = ham_data(4442 : end, :);
ham_train = ham_data(1111 : 4441, :);

% split spam mails into cv, test and train parts
spam_cv = spam_data(1:479, :);
spam_test = spam_data(1919 : end, :);
spam_train = spam_data(480 : 1918, :);

% merge spam and ham data
cv_data = [ham_cv; spam_cv];
test_data = [ham_test; spam_test];
train_data = [ham_train; spam_train];

% shuffle train set and create data(X) and labels(y)
train_data_shuffeled  = train_data(randperm(size(train_data,1)),:);
X = train_data_shuffeled(:, 1 : end - 1);
y = train_data_shuffeled(:, end);

% shuffle cv set and create data(X) and labels(y)
cv_data_shuffeled  = cv_data(randperm(size(cv_data,1)),:);
X_cv = cv_data_shuffeled(:, 1 : end - 1);
y_cv = cv_data_shuffeled(:, end);

% shuffle test set and create data(X) and labels(y)
test_data_shuffeld  = test_data(randperm(size(test_data,1)),:);
X_test = test_data_shuffeld(:, 1 : end - 1);
y_test = test_data_shuffeld(:, end);
