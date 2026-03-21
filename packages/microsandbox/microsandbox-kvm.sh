set -e
if $CI; then
    echo "Running in CI environment, skipping KVM check."
    return 0
fi

# Check if /dev/kvm exists
if [ ! -e /dev/kvm ]; then
    echo "/dev/kvm not found. Load kvm modules first."
    exit 1
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
    echo "User added to kvm group."
    if [ ! -e /dev/kvm ]; then
        echo "/dev/kvm still not found."
    exit 1
    fi
    return 0
fi

echo "Could not grant access. Try running with sudo."
exit 1
