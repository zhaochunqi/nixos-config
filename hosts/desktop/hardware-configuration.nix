#
# Hardware settings for my H310M S2H Desktop
#
# flake.nix
#  └─ ./hosts
#      └─ ./laptop
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
#

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel"];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  fileSystems."/" =
    { #device = "/dev/disk/by-uuid/80e0d316-954b-4959-8c5d-06be7255a036";
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { #device = "/dev/disk/by-uuid/FCCC-9ECD";
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  #fileSystems."/ssd" =
  #  { #device = "/dev/disk/by-uuid/748e6628-0f4e-4479-8940-daa8531d3390";
  #    device = "/dev/disk/by-label/ssd";
  #    fsType = "ntfs";
  #    options = [ "nofail" ];
  #  };

  fileSystems."/hdd" =
    { #device = "/dev/disk/by-uuid/bbab0f8a-50f4-4a7c-a0d3-0ccb036f11d5";
      device = "/dev/disk/by-label/hdd";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/toshiba1" =
    { #device = "/dev/disk/by-uuid/7491ea96-a62d-4202-ada7-8d0310dfc967";
      device = "/dev/disk/by-label/toshiba";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/toshiba2" =
    { #device = "/dev/disk/by-uuid/21307718-de74-4a24-aaa7-dd09f7e89e32";
      device = "/dev/disk/by-label/toshiba2";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/toshiba3" =
    { #device = "/dev/disk/by-uuid/7f5e9ea1-2bc3-44c5-9b6a-d8fe2a311b73"; 
      device = "/dev/disk/by-label/toshiba3";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/maxtor" =
    { #device = "/dev/disk/by-uuid/36E6613DE660FE8D";
      device = "/dev/disk/by-label/maxtor";
      fsType = "ntfs";
      options = [ "nofail" ];
    };

  fileSystems."/storage" =
    { #truenas smb storage
      device = "//192.168.0.3/storage";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},uid=1000,gid=100,credentials=/home/matthias/smb"];
    };

  #swapDevices =
  #  [
  #    { #device = "/dev/disk/by-uuid/7d0c3f66-c6eb-413c-956f-dfdd8ceb0cae";
  #      device = "/dev/disk/by-label/swap";
  #    }
  #  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    useDHCP = false;                            # Deprecated
    hostName = "desktop";
    #networkmanager.enable = true;
    enableIPv6 = false;
    interfaces = {
      enp2s0 = {                                # Change to correct network driver
        # useDHCP = true;                       # Disabled because fixed ip
        ipv4.addresses = [ {                    # Ip settings: *.0.50 for main machine
          address = "192.168.0.50";
          prefixLength = 24;
        } ];
      };
      #wlp2s0.useDHCP = true;                   # Wireless card
    };
    defaultGateway = "192.168.0.1";
    nameservers = [ "192.168.0.4" "1.1.1.1"];            # Pi-Hole DNS
    #nameservers = [ "1.1.1.1" "1.0.0.1" ];     # Cloudflare (when Pi-Hole is down)
  };
}
