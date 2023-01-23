.mode table
-- what birds, when and how often by time by bird then time
select hourOfDay, commonName, howMany from heardSumByHour where howMany <> 0 order by commonName, hourOfDay;  
-- select daytime, what, howmany from chart where howmany <> 0 order by what, daytime;
-- what birds, when and how often by time
select hourOfDay, commonName, howMany from heardSumByHour where howMany <> 0 order by hourOfDay;
-- select daytime, what, howmany from chart where howmany <> 0 order by daytime;
-- what birds and how often heard overall
select commonName, count(commonName) from heardRaw group by commonName;
-- select name,count(name) from found group by name;
-- what birds and how often heard yesterday
select commonName, count(commonName) from heardRaw where minuteOfDay > date('now','-1 day') group by commonName; 
-- select name,count(name) from found where heard > date('now','-1 day') group by name;
