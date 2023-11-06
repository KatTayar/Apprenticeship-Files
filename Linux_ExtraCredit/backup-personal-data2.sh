# Edited 

username="$(whoami)"

source_dir="/home/$username/data"
backup_dir="/home/$username/backups"


if [ ! -d "$source_dir" ]; then
  echo "Source directory '$source_dir' does not exist."
  exit 1
fi


if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi


backup_filename="data-backup-$(date +'%Y-%m-%d').tar.gz"
backup_file="$backup_dir/$backup_filename"


if [ -e "$backup_file" ]; then
  echo "Backup file '$backup_file' already exists."
  exit 1
fi


tar czf "$backup_file" -C "$source_dir" .


md5sum "$backup_file" >> "$backup_dir/checksums.txt"


log_file="$backup_dir/backup-log.txt"
echo "Backup of $source_dir successfully created at $backup_file" >> "$log_file"
