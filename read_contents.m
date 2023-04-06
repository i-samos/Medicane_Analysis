function [CC3]=read_contents(INITIAL,file);
try
    delete('diary')
catch
end
read_contents_exe(strcat(INITIAL,file));
diary on
read_contents_exe(strcat(INITIAL,'\',file));
diary off
CC3 = importfile('diary', 1);
delete('diary')
CC3 = cellstr(CC3);
[CC3(:,10),~]=strtok(CC3(:,10),'"');
[CC3(:,15),~]=strtok(CC3(:,15),'"');
[~,CC3(:,16)]=strtok(CC3(:,15),'[');
CC3(:,end+1)={strcat(INITIAL,'\',file)};
stringToCheck = 'GRIB1';
member=find(cellfun(@(x)contains(stringToCheck,x), CC3(:,1)));
CC3=CC3(member,:);
CC3(:,1)=[];
tmp=cell2mat(cellfun(@(x){str2double(x)}, CC3(:,11)));
tmp(tmp==1)=60;
tmp(tmp==0)=1;
CC3(:,11)=num2cell(tmp);
CC3(:,7)=num2cell(cell2mat(cellfun(@(x){str2double(x)}, CC3(:,7))));
CC3(:,9)=num2cell(cell2mat(cellfun(@(x){str2double(x)}, CC3(:,9))));
CC3(:,10)=num2cell(cell2mat(cellfun(@(x){str2double(x)}, CC3(:,10))));
clearvars tmp
% nco=ncgeodataset(strcat(INITIAL,file));
AN=datetime(CC3(:,3),'InputFormat','yyMMddHH');
try
    tmpHourFactor=CC3(:,13);
    tmpHourFactor=strrep(tmpHourFactor,'valid ', '');
    [tmpHourFactor,~]=strtok(tmpHourFactor,' ');
    [~,qwer]=strtok(tmpHourFactor,'??');
    tmpHourFactor=strrep(tmpHourFactor,'??', 'hr');
    tmpHourFactor=strrep(tmpHourFactor,'anl', '0min');
    [tmpHourFactor,mins]=strtok(tmpHourFactor,'min');
    [tmpHourFactor,hrs]=strtok(tmpHourFactor,'hr');
    [~,qwe4]=strtok(tmpHourFactor,'-');
    [qwe4,~]=strtok(qwe4,'-');
    ch1=find(~cellfun(@isempty,qwe4));
    ch2=find(~cellfun(@isempty,qwer));
    [tmpHourFactor,~]=strtok(tmpHourFactor,'-');
    tmpHourFactor(ch1)=qwe4(ch1);
    tmpHourFactor=str2num(str2mat(tmpHourFactor));
%     mins=find(~cellfun(@isempty,mins));
    hrs=find(~cellfun(@isempty,hrs));
    tmpHourFactor(hrs)=tmpHourFactor(hrs)*60;
    tmpHourFactor(ch2)=tmpHourFactor(ch2)*0.5;
    FC=AN+minutes(tmpHourFactor);
    FC_ACC=FC;
catch
    try
        FC=AN+ minutes(cell2mat(cellfun(@(x,y) x*y, CC3(:,9),CC3(:,11),'UniformOutput',false)));
        FC_ACC=AN+ minutes(cell2mat(cellfun(@(x,y) x*y, CC3(:,10),CC3(:,11),'UniformOutput',false)));
    catch
    end
end
CC3(:,17)=cellstr(AN);
try
    CC3(:,18)=cellstr(FC);
catch
    CC3(:,18)=cellstr(AN);
end
try
    CC3(:,19)=cellstr(FC_ACC);
catch
    CC3(:,19)=cellstr(AN);
end