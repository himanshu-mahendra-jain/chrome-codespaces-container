#!/bin/bash

cleanup() {
    echo "Caught signal, shutting down..."
    kill -TERM "$VNC_PID"
    kill -TERM "$NOVNC_PID"
    wait
    echo "Shutdown complete."
}

trap cleanup SIGTERM SIGINT

PROFILE_PATH="/home/chromer/.config/google-chrome"
rm -f "$PROFILE_PATH/SingletonLock"
rm -f "$PROFILE_PATH/SingletonCookie"
rm -f "$PROFILE_PATH/SingletonSocket"

mkdir -p /home/chromer/.vnc
mkdir -p /home/chromer/.config/openbox

echo "extension XInputExtension" > /home/chromer/.vnc/config

echo '#!/bin/sh' > /home/chromer/.vnc/xstartup
echo 'unset SESSION_MANAGER' >> /home/chromer/.vnc/xstartup
echo 'unset DBUS_SESSION_BUS_ADDRESS' >> /home/chromer/.vnc/xstartup
echo '# Launch Openbox within a D-Bus session for app compatibility' >> /home/chromer/.vnc/xstartup
echo 'exec dbus-launch --exit-with-session openbox-session' >> /home/chromer/.vnc/xstartup
chmod +x /home/chromer/.vnc/xstartup

echo "password" | vncpasswd -f > /home/chromer/.vnc/passwd
chmod 600 /home/chromer/.vnc/passwd

rm -f ~/.vnc/*.log

echo "Starting VNC server..."
vncserver -localhost no -fg -SecurityTypes None --I-KNOW-THIS-IS-INSECURE -geometry 1920x1080 -depth 24 &
VNC_PID=$!

echo "Starting noVNC proxy..."
websockify --web=/usr/share/novnc/ 6901 localhost:5901 &
NOVNC_PID=$!

echo "VNC PID: $VNC_PID | noVNC PID: $NOVNC_PID"
echo "Container is ready. Access via VNC client on port 5901 or web browser on port 6901."

wait -n

exit $?
