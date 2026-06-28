# digital-frame

This project is a gift idea for my parents that have a lot of digital photos and complained about issues with their current store bought digital photo frame.

Because i am a fan of RaspberryPi, i decided to go the DIY route and create a better digital photo frame, suited to their needs.

## v2 architecture

A fresh **Raspberry Pi OS Lite** flash boots straight into a fullscreen,
self-healing photo slideshow:

- **cage** (a single-app Wayland kiosk) runs **feh** fullscreen (feh via Xwayland).
- A **systemd service** (`slideshow.service`) runs `cage -- /usr/local/bin/slideshow`
  as the frame user with `Restart=always`, so a crash of feh/cage recovers within
  seconds with no human action.
- The HDMI mode is **forced in `cmdline.txt`** (`video=HDMI-A-1:1920x1080@60D`)
  to defeat the slow/late-monitor EDID handshake race, with a quiet boot.
- feh shows photos with whole-image fit (portraits pillarboxed, no crop) and EXIF
  auto-rotation.
- **Live USB read:** plug in a stick and photos appear. A udev rule mounts any
  inserted USB filesystem **read-only** at `/media/frame`
  (`ro,nosuid,nodev,noexec,uid=1000,gid=1000`) and restarts `slideshow.service`,
  so swapping a stick while powered on updates the show with no reboot. Read-only
  means the stick can be pulled anytime without corruption and the Pi never
  writes flash during a normal run. The image extensions found on each mount are
  logged to journald (`journalctl -t frame-usb`) to learn the real formats. With
  no stick inserted, the fallback image shows.

The sticks are exFAT (curated on a MacBook), so `exfatprogs` is installed.

### Repo layout

```
bootstrap.sh                  # curl-able entry point: installs git, clones repo, runs install.sh
install.sh                    # idempotent, re-runnable installer (run as root)
bin/slideshow                 # the feh launcher (installed to /usr/local/bin)
bin/frame-usb                 # USB mount/umount helper (installed to /usr/local/sbin)
etc/slideshow.service         # systemd unit
etc/frame-usb-mount@.service  # mounts a stick on udev add
etc/frame-usb-umount@.service # unmounts a stick on udev remove
etc/99-frame-usb.rules        # udev rule wiring USB add/remove to the services
assets/                       # black.jpg + fallback card
```

## Installation

On a freshly flashed Pi OS Lite, run as your normal user (not root):

```bash
curl -fsSL https://raw.githubusercontent.com/oforfamar/digital-frame/main/bootstrap.sh | bash
sudo reboot
```

The bootstrap clones the repo to `~/digital-frame` and runs `sudo ./install.sh`.

### Updating

```bash
cd ~/digital-frame && git pull && sudo ./install.sh
```

`install.sh` is idempotent, so re-running it is always safe.
