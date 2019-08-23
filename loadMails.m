clear ; close all; clc

cd mail/all_spam
n_spam_mails = size(glob('*'))
cd ..
cd ..

cd mail/all_ham
n_ham_mails = size(glob('*'))
cd ..
cd ..

vocabList = getVocabList();

spam_mails = [];
spam_data = [];

for i = 1:n_spam_mails
    try
        #disp('generate filename') -->0.000128984
        #tic()
        ii = sprintf('%04d', i)
        #toc()
        #disp('load mail') -->0.0222859
        #tic()
        spam_mails = [spam_mails; loadMail('all_spam', ii)];
        #toc()
        #disp('create word indices') #--> 6.06974
        #tic()
        word_indices = processEmail_manipulated(spam_mails(end,:), vocabList);
        #toc()
        #disp('create feature vector') -->0.00157595
        #tic()
        features = emailFeatures(word_indices)';
        #toc()
        #disp('expand feature vector with spam flag') --> 5.38826e-05
        #tic()
        features = [features 1];
        #toc()
        #disp('append feature vector to data matrix') --> 3.40939e-05
        #tic()
        spam_data = [spam_data; features];
        #toc()
    catch err
        disp(err.message)
        disp(ii)
    end
end

ham_mails = [];
ham_data = [];
for i = 1:n_ham_mails
    try
        ii = sprintf('%04d', i)
        ham_mails = [ham_mails; loadMail('all_ham', ii)];
        word_indices = processEmail_manipulated(ham_mails(end,:), vocabList);
        features = emailFeatures(word_indices)';
        features = [features 0];
        ham_data = [ham_data; features];
    catch err
        disp(err.message)
        disp(ii)
    end
end

save('-mat','email_data.mat', 'spam_data', 'ham_data')


