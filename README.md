#s3-backup#

Scripts and utilities for backups applications and databases up to AWS S3.

Thanks to woxxy for https://github.com/woxxy/MySQL-backup-to-Amazon-S3. That was leveraged heavily for general format.

Use in tandem with MySQL-backup-to-Amazon-S3 for a slick WordPress, Drupal, etc. backup solution on AWS.

##s3cmd setup##

###On Ubuntu:###
1.  <pre>sudo apt-get install s3cmd</pre>
2.  <pre>s3cmd --configure</pre> (this will require some settings from your AWS account)
3.  Create a bucket in S3 with the AWS console or <pre>s3cmd mb s3://unique-bucket_name</pre>
4.  put the script on your server: <pre>wget https://raw.github.com/ahardin/s3-backup/master/s3-backup-app.sh</pre>
5.  make changes as indicated by comments
6.  run the script or add it to crontab

###Other platforms###
http://s3tools.org/s3cmd