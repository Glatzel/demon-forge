set -e
# Check if /dev/kvm exists
if [ ! -e /dev/kvm ]; then
    echo "/dev/kvm not found. Load kvm modules first."
    return 0
fi

# Check access
if [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
    return 0
fi

# Try kvm group method
if [ "$(stat -c "%G" /dev/kvm)" = "kvm" ]; then
    echo "Try add User to kvm group."
    sudo usermod -aG kvm "$USER"
    newgrp kvm
    return 0
fi

echo "Could not grant access. Try running with sudo."
exit 1
