# backup Directory

This is where backups are written.

---

### File naming:

* YEAR-MON-DAY
	* Timestamp of when the backup was produced.
* source name
	* Name of the source data that necessitated the backup.
* .db.gz
	* Database backup.
* .tgz
	* Directory backup.

### Dependencies:

* [sshpass](https://stackoverflow.com/questions/12202587/automatically-enter-ssh-password-with-script)
