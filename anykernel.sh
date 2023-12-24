### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=Pineaple Kernel by @Kizziama
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=topaz
device.name2=tapas
supported.versions=13.0 - 14.0
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

# boot shell variables
slot=$(find_slot);
block=/dev/block/bootdevice/by-name/boot$slot;
is_slot_device=1;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
split_boot;

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d $ramdisk/overlay ]; then
  rm -rf $ramdisk/overlay;
fi;

# end ramdisk changes

flash_boot;
## end install

sleep 3
ui_print ""
ui_print "✓ kernel installed successfully"

