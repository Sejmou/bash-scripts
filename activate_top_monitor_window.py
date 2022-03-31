import subprocess
import re
import math
import sys
from collections import defaultdict


def main():
    if len(sys.argv) != 2:
        # note: first entry in args is always name of script
        raise ValueError("Single integer argument (selected monitor) expected!")

    selected_monitor = int(sys.argv[1])

    monitor_width = 1920
    desktop_width = get_desktop_width()
    no_of_monitors = int(desktop_width / monitor_width)

    if selected_monitor < 0 or selected_monitor >= no_of_monitors:
        raise ValueError(
            f"Invalid monitor ID! Choose either from {list(range(no_of_monitors))}, as {no_of_monitors} monitors are connected."
        )

    windows_by_z_idx = get_windows_by_z_idx()
    window_monitors = get_window_monitors(desktop_width, monitor_width)

    windows_per_monitor = defaultdict(list)
    for window_id in windows_by_z_idx:
        monitor = window_monitors[window_id]
        windows_per_monitor[monitor].append(window_id)

    subprocess.run(
        f"wmctrl -i -a {windows_per_monitor[selected_monitor][-1]}".split(" ")
    )


def consecutive_whitespace_except_newline_to_space(str):
    return re.sub("[^\S\n]+", " ", str)


def get_desktop_width():
    return int(
        # select currently active desktop (marked with * in output of wmctrl -d)
        # then search for field containing desktop dimensions (widthxheight) and extract width
        subprocess.getoutput("wmctrl -d | grep \* | cut -d' ' -f5 | cut -d'x' -f1")
    )


def get_window_monitors(desktop_width, monitor_width):
    window_info_lines = consecutive_whitespace_except_newline_to_space(
        subprocess.getoutput("wmctrl -lG")
    ).split("\n")

    def get_monitor(x_pos):
        return math.floor(x_pos / monitor_width)

    def get_window_id_and_monitor(window_info_line):
        line_cols = window_info_line.split(" ")
        window_id = int(line_cols[0], 16)
        window_xpos = int(line_cols[2], 10)
        return window_id, get_monitor(window_xpos)

    return dict(get_window_id_and_monitor(line) for line in window_info_lines)


def get_windows_by_z_idx():
    """
    returns all windows of the desktop, ordered by z-index (caution: index 0 is furthest away from top!)
    """

    xprop_output = subprocess.getoutput("xprop -root _NET_CLIENT_LIST_STACKING")
    no_whitespace = "".join(xprop_output.split())
    window_id_strings = no_whitespace[no_whitespace.index("#") + 1 :].split(",")
    return [int(id_str, 16) for id_str in window_id_strings]


main()
