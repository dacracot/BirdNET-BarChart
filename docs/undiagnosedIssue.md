# An undiagnosed issue during development.

I'm unsure of the cause which required my having to look into this issue.  The system was
showing a noticeable slow down in performance, reflected in the load average hovering
around 5 during normal operations.  This was up significantly from a load that I never
even thought to look at a month ago.  Below I present a few facts and opinions as to what
could be the cause and what brought me to the current theory.

---

### Things I regularly do:

1. I do all of my development on the this singular rpi4b
	* Three or four terminal sessions running htop and sqlite in two of the sessions.
	* Actively using the git repo hosted on github.com including a status query as part of my command prompt.
	* Installing and uninstalling software from anywhere (albeit mostly from the debian repo).
	* Using a GUI code editor (BBEdit) on MacOS to open and edit code.  It implements this using sftp.
1. I run my software in a weather proof box outside.
	* The latest test is during the running of the code in the current branch.
	* This includes an hourly running of the analyzer, a large python application which uses tensorflow.
	* This also include streaming audio from a microphone to wav files in one minute intervals 24/7.

---

### Things I have tried and aborted in the line of development:

1. I tried a tool that ran in a docker container.
	* I had to install docker without the aid of the OS tools such as apt.
	* I had had a bad experience year ago with docker on a linux system
	* I was unsuccessful with this tool and decided to remove it and its dependencies.
	* Removing docker is easier said than done.
1. I have tried numerous tools installed via apt and remove via apt.

---

### Symptoms of the problem:

1. Getting very slow.
	* Saving a file via sftp was taking two to five seconds, occasionally longer and timing out.
	* Prompts on the command line could take two to five seconds response.
	* IO blocking would occasionally block audio streaming.

---

### What I started trying:

1. Use a singular session rather than three or four.
	* No change.
1. Remove the git status from my command line prompt.
	* No change.
1. Develop with the software idle rather than running 24/7.
	* No change.
1. Search for CPU pigs.
	* None found.
1. Search for memory pigs.
	* None found.

---

### What seems to have worked with journald:

1. Add the following to /etc/systemd/journald.conf:
	* `Storage=volatile`
	* `RuntimeMaxUse=64M`
	* `ForwardToConsole=no`
	* `ForwardToWall=no`
1. Restart the service:
	* `systemctl restart systemd-journald`
1. Delete the journald log files:
	* `rm -rf /var/log/journal`

---

### After three weeks of normal usage:

1. This seems to be fixed:
	* Load is running at 0.0 to 0.2 normally.
	* I doubt it was from the audio recording, since it has not returned.
	* Could it be from the failed Docker experiment?  Perhaps.
