import enum
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

    desktop_width = get_desktop_width()
    monitor_x_offsets = get_monitor_x_offsets()
    no_of_monitors = len(monitor_x_offsets)

    if selected_monitor < 0 or selected_monitor >= no_of_monitors:
        raise ValueError(
            f"Invalid monitor ID! Choose either from {list(range(no_of_monitors))}, as {no_of_monitors} monitors are connected."
        )

    window_ids_by_z_idx = get_window_ids_by_z_idx()

    window_monitors = get_window_monitors(desktop_width, monitor_x_offsets)

    windows_per_monitor = defaultdict(list)
    for window_id in window_ids_by_z_idx:
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


def get_window_monitors(desktop_width, x_offsets):
    window_info_lines = consecutive_whitespace_except_newline_to_space(
        subprocess.getoutput("wmctrl -lG")
    ).split("\n")

    print(x_offsets)

    def get_monitor(x_pos):
        while x_pos > desktop_width:
            x_pos = x_pos - desktop_width + 1

        monitor = 0
        x_offset = 0
        print(x_pos)

        for curr_monitor, curr_offset in enumerate(x_offsets):
            print(
                f"{curr_monitor}:",
                curr_offset,
                curr_offset + 1920 if curr_monitor < len(x_offsets) - 1 else "(last)",
            )
            if curr_offset <= x_pos and curr_offset >= x_offset:
                monitor = curr_monitor
                x_offset = curr_offset

        print("selected:", monitor)
        return monitor

    def get_window_id_and_monitor(window_info_line):
        line_cols = window_info_line.split(" ")
        window_id = int(line_cols[0], 16)
        window_xpos = int(line_cols[2])

        print()
        print(hex(window_id))
        print(window_xpos)

        return window_id, get_monitor(window_xpos)

    return dict(get_window_id_and_monitor(line) for line in window_info_lines)


def get_window_ids_by_z_idx():
    """
    returns all windows of the desktop, ordered by z-index (caution: index 0 is furthest away from top!)
    """

    xprop_output = subprocess.getoutput("xprop -root _NET_CLIENT_LIST_STACKING")
    no_whitespace = "".join(xprop_output.split())
    window_id_strings = no_whitespace[no_whitespace.index("#") + 1 :].split(",")
    return [int(id_str, 16) for id_str in window_id_strings]


def get_monitor_x_offsets():
    xrandr_out = subprocess.getoutput("xrandr | grep '\sconnected'").split("\n")

    def extract_monitor_x_offset(xrandr_out_line):
        # width = re.search(r"[0-9]+x[0-9]+", xrandr_out_line).group(0).split("x")[0]
        match = re.search(r"\+[0-9]+", xrandr_out_line)
        if match:
            xoffset = int(match.group(0)[1:])
            return xoffset

    x_offsets = []
    for line in xrandr_out:
        x_offset = extract_monitor_x_offset(line)
        if x_offset != None:  # monitor connected
            x_offsets.append(x_offset)

    return x_offsets


main()
