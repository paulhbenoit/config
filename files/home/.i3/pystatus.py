from i3pystatus import Status

status = Status()

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%a %-d %b %X",)

status.register("text", text="        ",)

# TODO: auto-determine number of batteries

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
status.register("battery",
    battery_ident="BAT0",
    format="B0 {percentage:.0f}%{status}/{consumption:.0f}W {remaining:%E%hh:%Mm}",
    alert=False,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)


status.register("battery",
    battery_ident="BAT1",
    format="B0 {percentage:.0f}%{status}/{consumption:.0f}W {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

status.register("text", text="        ",)


# Displays whether a DHCP client is running
status.register("runwatch",
    name="DHCP",
    path="/var/run/dhclient*.pid",)

# TODO: auto-determine network interface names
# TODO: https://wiki.archlinux.org/index.php/Network_configuration#Network_interfaces

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="enp0s31f6",
    format_up="{v4cidr}",)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlp4s0",
    format_up="{essid} {quality:03.0f}%",)


status.register("text", text="        ",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    format="SSD {avail}G free",)

status.register("text", text="        ",)

# Shows memory
status.register("mem",
    format="RAM {used_mem:02.0f}G",
    divisor=1073741824,)

status.register("text", text="        ",)

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    format="{temp:.0f}°C",)

# Displays cpu usage
status.register("cpu_usage",
    format="{usage_cpu3:02d}%",)
status.register("cpu_usage",
    format="{usage_cpu2:02d}%",)
status.register("cpu_usage",
    format="{usage_cpu1:02d}%",)
status.register("cpu_usage",
    format="{usage_cpu0:02d}%",)



status.run()
