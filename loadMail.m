function email_content = loadMail(folder_name, file_name)

#load email .txt file into octave variable
file_name_with_extension = [file_name '.txt'];
urlname = ['file:///' fullfile(pwd, 'mail', folder_name, file_name_with_extension)];
# urlname = ['file:///' fullfile(pwd, 'mail', 'test', folder_name, file_name_with_extension)];
try
    email_content = urlread(urlname);
catch err
    disp(err.message)
end



