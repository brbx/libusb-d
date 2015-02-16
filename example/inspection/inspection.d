/**
 * Device inspection example using D-Language bindings to LibUSB-1.0
 *
 * Authors: Ross Lonstein <lonstein@brightboxcharge.com>
 * License: LGPL
 * Copyright: 2015, Brightbox, Inc.
 * See_Also: http://libusbx.org
 */

import libusb;
import std.stdio;
import std.conv;
import std.algorithm;
import core.stdc.errno;
import core.stdc.string : strerror;

int main() {
  libusb_context *ctx;
  auto rc = libusb_init(&ctx);
  assert(rc == libusb_error.LIBUSB_SUCCESS);
  
  //libusb_set_debug(ctx, libusb_log_level.LIBUSB_LOG_LEVEL_DEBUG);
  libusb_set_debug(ctx, libusb_log_level.LIBUSB_LOG_LEVEL_INFO);

  libusb_version *vers = libusb_get_version();
  writefln("Major %d, Minor %d, Micro %d, Nano %d, rc '%s'\nDescription: %s",
           vers.major, vers.minor, vers.micro, vers.nano, to!string(vers.rc), to!string(vers.describe));

  assert(vers.major == 1);

  // Walk the bus, enumerating devices and their configs
  libusb_device **devlist;
  ptrdiff_t devcount = libusb_get_device_list(ctx, &devlist);
  assert(devcount > 0);
  
  for (ptrdiff_t i; i<devcount; i++) {
    libusb_device *device = devlist[i];

    uint dev_bus   = libusb_get_bus_number(device);
    uint dev_addr  = libusb_get_device_address(device);
    int  dev_speed = libusb_get_device_speed(device);
    
    writefln("Device #%d: Bus %d, Address %d, Speed %d", i, dev_bus, dev_addr, dev_speed);

    libusb_device_descriptor desc;
    rc = libusb_get_device_descriptor(device, &desc);
    assert(rc == libusb_error.LIBUSB_SUCCESS);

    writefln("  Class 0x%0.2x, Vendor Id 0x%0.4x, Product Id 0x%0.4x",
             desc.bDeviceClass, desc.idVendor, desc.idProduct);

    libusb_device_handle *handle;
    char[256] manufacturer;
    rc = libusb_open(device, &handle);
    if (rc < 0) {
      int e = errno;
      writefln("Failed to open device: %s (%d)", to!string(strerror(e)), e);
    }
    else {
      rc = libusb_get_string_descriptor_ascii(handle, desc.iManufacturer, manufacturer.ptr, manufacturer.sizeof);
      if (rc < 0) {
        writeln("  Manufacturer unknown");
      }
      else {
        writefln("  Manufacturer '%s'", to!string(manufacturer).until("\x00"));
      }
      libusb_close(handle);
    }
    
    for(ubyte cfgidx; cfgidx < desc.bNumConfigurations; cfgidx++) {
      libusb_config_descriptor *dev_cfg;
      rc = libusb_get_config_descriptor(device, cfgidx, &dev_cfg);
      assert(rc == libusb_error.LIBUSB_SUCCESS);

      const libusb_interface *iface = dev_cfg.iface; // N.B. keyword "interface" replaced in struct with "iface" !!
      const libusb_interface_descriptor *altsetting = iface.altsetting;

      writefln("  Configuration #%d has %d interfaces with %d endpoints",
               cfgidx, dev_cfg.bNumInterfaces, altsetting.bNumEndpoints);
      libusb_free_config_descriptor(dev_cfg);
    }
  }
  libusb_free_device_list(devlist, devcount);

  libusb_exit(ctx);
  
  return 0;
}
