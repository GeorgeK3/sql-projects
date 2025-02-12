CREATE USER examiner FROM LOGIN examiner
EXEC sp_addrolemember 'db_datareader', 'examiner';
