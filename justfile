vm:
    nixos-rebuild build-vm -I nixos-config=./configuration.nix

run-vm:
    ./result/bin/run-nixos-vm-vm -nographic

clean:
    rm -f nixos-vm.qcow2
    rm -rf result
