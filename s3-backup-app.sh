############################################################################
# name of the S3 bucket that you have already created
S3BUCKET=bucket_name
# path within S3BUCKET where backups will be saved. MUST be blank or end in /
S3PATH=backups/
# format to your liking
DATE=$(date +"%Y%m%d_%H%M")
# string to be prepended to date in file names
FILEPREFIX=prefix
# directory being backed up
APPDIR=app_directory
# directory where local file will be saved before putting
TMP_PATH=~/
############################################################################

FILENAME=${TMP_PATH}${FILEPREFIX}${DATE}.tar.gz

# used in S3 path. can be used to have daily, weekly, monthly, etc. backups
PERIOD=${1-day}
echo "Period: $PERIOD."

echo "Zipping files..."
tar czf $FILENAME -C ${APPDIR} .
echo "Done zipping."

# remove 2nd to last backup
echo "Removing old backup (2 ${PERIOD}s ago)..."
s3cmd del --recursive s3://${S3BUCKET}/${S3PATH}previous_${PERIOD}/
echo "Old backup removed."

echo "Moving the backup from past $PERIOD to the previous folder..."
s3cmd mv --recursive s3://${S3BUCKET}/${S3PATH}${PERIOD}/ s3://${S3BUCKET}/${S3PATH}previous_${PERIOD}/
echo "Past backup moved."

# upload the new backup
echo "Uploading the new backup..."
s3cmd put -f $FILENAME s3://${S3BUCKET}/${S3PATH}${PERIOD}/
echo "New backup uploaded."

echo "Remove temporary files..."
rm $FILENAME
echo "Done!"