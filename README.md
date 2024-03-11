# Slackworld Simple Repository Search

Few lines of bash script code that helps search for packages and versions on the Slackware Linux world.

```
[v@arcadia slackworld.simple.repo.search]$ bash slackworld.simple.repo.search.sh alsa
+--------------------------------------+
INSTALLED: n/a alsa-lib-1.2.5.1-x86_64-1
INSTALLED: n/a alsa-oss-1.1.8-x86_64-3
INSTALLED: n/a alsa-plugins-1.2.5-x86_64-1
INSTALLED: n/a alsa-utils-1.2.5.1-x86_64-1
SBO-15.0: build_it/from_source alsa-plugin-jack-1.2.5-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source alsa-tools-1.2.5-x86_64-2_SBo.tgz
SBO-15.0: build_it/from_source alsacap-20200821-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source alsaequal-0.6-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source alsamixergui-0.9.0rc2-x86_64-3_SBo.tgz
SBO-15.0: build_it/from_source alsamodularsynth-2.2.0-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source pyalsaaudio-0.8.4-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source xfce4-alsa-plugin-0.3.0-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source bluez-alsa-3.1.0-x86_64-2_SBo.tgz
SBO-15.0: build_it/from_source clalsadrv-2.0.0-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source zita-alsa-pcmi-0.3.2-x86_64-1_SBo.tgz
SLACKEL-i486: slackel/extra pyalsaaudio-0.7-i486-2dj.txz
SLACKEL-x86_64: slackel/extra pyalsaaudio-0.7-x86_64-2dj.txz
ALIEN-ALL: alsa-plugins-jack/pkg/15.0 alsa-plugins-jack-1.2.5-i586-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg/current alsa-plugins-jack-1.2.7.1-i586-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg64/15.0 alsa-plugins-jack-1.2.5-x86_64-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg64/current alsa-plugins-jack-1.2.7.1-x86_64-1alien.txz
ALIEN-ALL: zita-alsa-pcmi/pkg/14.2 zita-alsa-pcmi-0.3.2-i586-1alien.tgz
ALIEN-ALL: zita-alsa-pcmi/pkg/15.0 zita-alsa-pcmi-0.3.2-i586-1alien.tgz
ALIEN-ALL: zita-alsa-pcmi/pkg/current zita-alsa-pcmi-0.3.2-i586-1alien.tgz
ALIEN-ALL: zita-alsa-pcmi/pkg64/14.2 zita-alsa-pcmi-0.3.2-x86_64-1alien.tgz
ALIEN-ALL: zita-alsa-pcmi/pkg64/15.0 zita-alsa-pcmi-0.3.2-x86_64-1alien.tgz
ALIEN-ALL: zita-alsa-pcmi/pkg64/current zita-alsa-pcmi-0.3.2-x86_64-1alien.tgz
SLACKWARE64-15.0: slackware64/ap alsa-utils-1.2.5.1-x86_64-1.txz
SLACKWARE64-15.0: slackware64/l alsa-lib-1.2.5.1-x86_64-1.txz
SLACKWARE64-15.0: slackware64/l alsa-oss-1.1.8-x86_64-3.txz
SLACKWARE64-15.0: slackware64/l alsa-plugins-1.2.5-x86_64-1.txz
+--------------------------------------+
[v@arcadia slackworld.simple.repo.search]$
```
## Grep regex

You know. As the script is simple and use grep, you can use triks to reduce the sort of packages.
Notice the space between "jack-1" and " jack-1".

```
[v@arcadia slackworld.simple.repo.search]$ bash slackworld.simple.repo.search.sh jack-1
+--------------------------------------+
INSTALLED: n/a jack-1.9.22-x86_64-1_SBo
SBO-15.0: build_it/from_source alsa-plugin-jack-1.2.5-x86_64-1_SBo.tgz
SBO-15.0: build_it/from_source jack-1.9.22-x86_64-1_SBo.tgz
SLACKEL-i486: slackel/extra jack-1.9.14-i586-1dj.txz
SLACKEL-x86_64: slackel/extra jack-1.9.14-x86_64-1dj.txz
ALIEN-ALL: alsa-plugins-jack/pkg/15.0 alsa-plugins-jack-1.2.5-i586-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg/current alsa-plugins-jack-1.2.7.1-i586-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg64/15.0 alsa-plugins-jack-1.2.5-x86_64-1alien.txz
ALIEN-ALL: alsa-plugins-jack/pkg64/current alsa-plugins-jack-1.2.7.1-x86_64-1alien.txz
ALIEN-ALL: pipewire-jack/pkg/current pipewire-jack-1.0.1-i586-1alien.txz
ALIEN-ALL: pipewire-jack/pkg64/current pipewire-jack-1.0.1-x86_64-1alien.txz
ALIEN-ALL: pulseaudio-jack/pkg/15.0 pulseaudio-jack-15.0-i586-1alien.txz
ALIEN-ALL: pulseaudio-jack/pkg/current pulseaudio-jack-17.0-i586-2alien.txz
ALIEN-ALL: pulseaudio-jack/pkg64/15.0 pulseaudio-jack-15.0-x86_64-1alien.txz
ALIEN-ALL: pulseaudio-jack/pkg64/current pulseaudio-jack-17.0-x86_64-2alien.txz
+--------------------------------------+
[v@arcadia slackworld.simple.repo.search]$ bash slackworld.simple.repo.search.sh " jack-1"
+--------------------------------------+
INSTALLED: n/a jack-1.9.22-x86_64-1_SBo
SBO-15.0: build_it/from_source jack-1.9.22-x86_64-1_SBo.tgz
SLACKEL-i486: slackel/extra jack-1.9.14-i586-1dj.txz
SLACKEL-x86_64: slackel/extra jack-1.9.14-x86_64-1dj.txz
+--------------------------------------+
[v@arcadia slackworld.simple.repo.search]$
```

## Contributing
All contributions are welcome.

## Author

* **Viel Losero** - *Initial work* - [Viel Losero](https://github.com/VielLosero)

## Copyrights

Slackware® is a Registered Trademark of Patrick Volkerding. 

Linux® is a Registered Trademark of Linus Torvalds.

## License
