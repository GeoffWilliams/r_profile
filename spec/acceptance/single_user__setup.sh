cat <<EOF > /usr/lib/systemd/system/emergency.service
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

[Unit]
Description=Emergency Shell
Documentation=man:sulogin(8)
DefaultDependencies=no
Conflicts=shutdown.target
Conflicts=rescue.service
Before=shutdown.target

[Service]
Environment=HOME=/root
WorkingDirectory=/root
ExecStartPre=-/bin/plymouth quit
ExecStartPre=-/bin/echo -e 'Welcome to emergency mode! After logging in, type "journalctl -xb" to view\\nsystem logs, "systemctl reboot" to reboot, "systemctl default" or ^D to\\ntry again to boot into default mode.'
ExecStart=-/bin/bash
Type=idle
StandardInput=tty-force
StandardOutput=inherit
StandardError=inherit
KillMode=process
IgnoreSIGPIPE=no
SendSIGHUP=yes

EOF

cat <<EOF > /usr/lib/systemd/system/rescue.service
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

[Unit]
Description=Rescue Shell
Documentation=man:sulogin(8)
DefaultDependencies=no
Conflicts=shutdown.target
After=sysinit.target plymouth-start.service
Before=shutdown.target

[Service]
Environment=HOME=/root
WorkingDirectory=/root
ExecStartPre=-/bin/plymouth quit
ExecStartPre=-/bin/echo -e 'Welcome to emergency mode! After logging in, type "journalctl -xb" to view\\nsystem logs, "systemctl reboot" to reboot, "systemctl default" or ^D to\\nboot into default mode.'
ExecStart=-/bin/bash
Type=idle
StandardInput=tty-force
StandardOutput=inherit
StandardError=inherit
KillMode=process
IgnoreSIGPIPE=no
SendSIGHUP=yes

EOF