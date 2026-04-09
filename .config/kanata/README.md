# Install

Kanata's [installation instructions 🔗](https://github.com/jtroo/kanata?tab=readme-ov-file#usage) for different operation systems.

I have installed using cargo:

```bash
# install
cargo install kanata

# update via cargo subcommand: cargo install cargo-update
cargo install-update -a
```

# Running Kanata

## As a program

Kanata has an event loop and needs to run in the background to intercept key presses.

```bash
# as a CLI program
kanata [-c, --cfg] <path/to/config.kbd>
```

## As a background service

It is recommended to create a background service so that Kanata executes on start-up. Sample `.service` file:

```bash
# /etc/systemd/system/kanata.service
[Unit]
Description=Kanata Keyboard Service
Documentation=https://github.com/jtroo/kanata
After=local-fs.target

[Service]
Type=simple
ExecStartPre=/usr/sbin/modprobe uinput # this may be specific to ubuntu
ExecStart=/home/lscr/.cargo/bin/kanata -c /home/lscr/.config/kanata/<config>.kbd # update
Restart=no

[Install]
WantedBy=multi-user.target
```

To enable the service:

```bash
sudo systemctl daemon-reload
sudo systemctl start kanata.service
sudo systemctl enable kanata.service
```


## Other things

Disabling Screen Reader on Ubuntu 24.04:

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader "[]"
```

Disable `Super + space` keyboard switching in Ubuntu 24.04:

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
```

Disable `Super + L` - Lock the screen:

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '[]'
```


# MacOS Reference

A decent reference: https://github.com/nmfirdausw/kanata-config
