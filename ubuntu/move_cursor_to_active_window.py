import subprocess
import re
import warnings

# moves the mouse cursor to the center of the currently focused window
# xdotool and xwininfo need to be installed!


def main():
    active_window_id = int(subprocess.getoutput("xdotool getwindowfocus"))
    x, y = get_center_x_and_y(active_window_id)
    subprocess.run(f"xdotool mousemove {x} {y}".split(" "))


def get_window_pos_and_size(window_id):
    filter_params = [
        "Absolute upper-left X",
        "Absolute upper-left Y",
        "Width",
        "Height",
    ]
    filter_params_str = " ".join([f"-e '{param}'" for param in filter_params])

    cmd = f"xwininfo -id {hex(window_id)} | grep -w {filter_params_str}"
    out = subprocess.getoutput(cmd)
    search_result = re.findall(r"[0-9]+", out)

    if search_result != None:
        x = int(search_result[0])
        y = int(search_result[1])
        width = int(search_result[2])
        height = int(search_result[3])
        return x, y, width, height
    else:
        warnings.warn(
            f"output of command ({cmd}) was:",
            out,
            "\nCould not find position and size of window",
        )


def get_center_x_and_y(window_id):
    x, y, width, height = get_window_pos_and_size(window_id)
    return x + width / 2, y + height / 2


main()
