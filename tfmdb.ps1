cmd.exe /c chcp 1252 | Out-Null
psql -h tfm.c5zhvwqtkswu.us-gov-west-1.rds.amazonaws.com -p 5432 -d tfmdb-dev -U postgres