#!/bin/bash
set -e

if [ "$1" == "undo" ] || [ "$1" == "--undo" ]; then
    echo "=== [🐾] Reverting Podman Core Configurations ==="
    
    # 1. Undo the One Share (Turn rshared back to private)
    sudo mount --make-private /
    echo "[+] Reverted root propagation to private."

    # 2. Undo the Two +s (Remove SUID bits)
    sudo chmod u-s /usr/bin/newuidmap
    sudo chmod u-s /usr/bin/newgidmap
    echo "[+] Removed SUID bits from newuidmap and newgidmap."
    
    echo "=== [🎉] Reversion complete喵! ==="
else
    echo "=== [🐾] Applying Podman Core Configurations ==="

    # 1. The One Share
    sudo mount --make-rshared /
    echo "[+] Applied: mount --make-rshared /"

    # 2. The Two +s
    sudo chmod u+s /usr/bin/newuidmap
    sudo chmod u+s /usr/bin/newgidmap
    echo "[+] Applied: chmod +s for mapping tools."

    echo "=== [🎉] Execution successful! Go craft your Minecraft world喵! ==="
fi