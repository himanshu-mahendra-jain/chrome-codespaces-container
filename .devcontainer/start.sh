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

VNC_DIR="/home/chromer/.config/tigervnc"
mkdir -p "$VNC_DIR"

echo '#!/bin/sh' > "$VNC_DIR/xstartup"
echo 'unset SESSION_MANAGER' >> "$VNC_DIR/xstartup"
echo 'unset DBUS_SESSION_BUS_ADDRESS' >> "$VNC_DIR/xstartup"
echo '# Launch Openbox within a D-Bus session for app compatibility' >> "$VNC_DIR/xstartup"
echo 'exec dbus-launch --exit-with-session openbox-session' >> "$VNC_DIR/xstartup"
chmod +x "$VNC_DIR/xstartup"

echo "password" | vncpasswd -f > "$VNC_DIR/passwd"
chmod 600 "$VNC_DIR/passwd"

rm -f "$VNC_DIR"/*.log

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
