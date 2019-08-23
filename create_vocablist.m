clear ; close all; clc

cd mail/all_spam
n_spam_mails = size(glob('*'))
cd ..
cd ..


cd mail/all_ham
n_ham_mails = size(glob('*'))
cd ..
cd ..

split_str = [];

for i = 1 : n_spam_mails
    try
        ii = sprintf('%04d', i)
        str = loadMail('all_spam', ii);
        split_str = [split_str; strsplit(str)'];
        
    catch err
        disp(err.message)
        disp(ii)
    end
end

for i = 1 : n_ham_mails
    try
        ii = sprintf('%04d', i)
        str = loadMail('all_ham', ii);
        split_str = [split_str; strsplit(str)'];
        
    catch err
        disp(err.message)
        disp(ii)
    end
end



[unique_words, ~, occurrences] = unique(split_str);
unique_counts = hist(occurrences, 1:max(occurrences));

col = 1 : length(unique_counts);
indexed_counts = [ col', unique_counts'];

sorted_counts = sortrows(indexed_counts, -2);

fileID = fopen('vocab_list_new.txt','w');
formatSpec = '%d %s \n';

word_counter = 0

for i = 1 : 50000
    disp(i)
    word = unique_words{sorted_counts(i)};
    #remove everything except chars a-z and A-Z
    chars_only_word = regexprep(word, '[^a-zA-Z]', '');
    #stem words
    try 
        stemmed_word = porterStemmer(strtrim(chars_only_word)); 
    catch 
        stemmed_word = ''; 
        continue;
    end;
    if strcmp(stemmed_word,'') == 0
        word_counter++;
        fprintf(fileID,formatSpec, word_counter, stemmed_word);
    end
end
fclose(fileID);

%save('-mat','email_data.mat', 'spam_data', 'ham_data')
