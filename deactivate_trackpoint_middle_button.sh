# disables trackpoint middle button (on ThinkPads)
# with this solution, scrolling with the middle button and track point still works, but every other trackpoint middle button funcitonality is removed
# for middle mouse button actions you can then simply tap the touchpad with three fingers instead
# to make sure this script runs on every Ubuntu startup:
#   1. Open 'Startup Applications Preferences'
#   2. Click 'Add'
#   3. In 'command' field, type 'bash ' and paste the absolute path to this script afterwards
trackpoint_id=$(xinput --list | grep 'Elan TrackPoint' | grep -oP '(?<=id\=)[0-9]+')
button_map=$(xinput --get-button-map $trackpoint_id)
new_button_map=$(echo $button_map | sed '0,/2/{s/2/0/}')
xinput --set-button-map $trackpoint_id $new_button_map