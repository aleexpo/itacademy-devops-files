### Настройка непривилегированных сессий

#### Конфигурация по умолчанию

* В домашней директории пользователя создайте директорию `.config/lxc`, в неё скопируйте файл /etc/lxc/default.conf

  1. Измените значение *lxc.apparmor.profile* на *unconfined*
  1. Добавьте в файл настройки отображения *uid* и *gid* (значения должны совпадать со значениями в /etc/subuid и /etc/subgid):
    ```
    lxc.idmap = u 0 100000 65536
    lxc.idmap = g 0 100000 65536
    ```

* В файл /etc/sysctl.conf добавьте параметр
```
kernel.unprivileged_userns_clone = 1
```

* В файле /etc/default/grub найдите строку GRUB_CMDLINE_LINUX и добавьте к значению ` systemd.legacy_systemd_cgroup_controller=yes`. Пример того, как будет выглядеть строка конфигурации:
```bash
GRUB_CMDLINE_LINUX="net.ifnames=0 systemd.legacy_systemd_cgroup_controller=yes"
```
Для того, чтобы изменения были применены, необходимо выполнить команду `update-grub`.

* После предыдущих двух изменений необходимо перезагрузить ОС

#### Настройка сети

В файл /etc/lxc/lxc-usernet необходимо добавить строку
```
your-username veth lxcbr0 10
```



### Настройка сети

* Задайте настройки сети по умолчанию в файле */etc/default/lxc-net*:
```bash
USE_LXC_BRIDGE="true"
LXC_BRIDGE="lxcbr0"
LXC_ADDR="10.0.3.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="10.0.3.0/24"
LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
LXC_DHCP_MAX="253"
LXC_DHCP_CONFILE=""
LXC_DOMAIN=""
```

* Включите службу lxc-net
```bash
systemctl enable lxc-net
systemctl start lxc-net
```

* Настройте сеть в вашей конфигурации по умолчанию (~/.config/lxc/default.conf)
```
lxc.net.0.type  = veth
lxc.net.0.flags = up
lxc.net.0.link  = lxcbr0
```
