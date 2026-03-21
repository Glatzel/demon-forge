set -e
if $CI; then
    echo "Running in CI environment, skipping KVM check."
    return 0  
fi

# Check CPU virtualization support
if ! grep -Eq '(vmx|svm)' /proc/cpuinfo; then
    echo "CPU virtualization not supported (vmx/svm missing)"
    exit 1
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

# Try ACL method
if command -v setfacl >/dev/null 2>&1; then
    sudo setfacl -m u:${USER}:rw /dev/kvm || true
fi

# Re-check access
if [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
    echo "Access granted using ACL"
    return 0
fi

# Try kvm group method
if [ "$(stat -c "%G" /dev/kvm)" = "kvm" ]; then
    sudo usermod -aG kvm "$USER"
    echo "User added to kvm group. Log out and log in again."
    return 0
fi

echo "Could not grant access. Try running with sudo."
exit 1
