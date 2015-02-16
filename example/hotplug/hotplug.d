/**
 * Hotplug example using D-Language bindings to LibUSB-1.0
 *
 * Authors: Ross Lonstein <lonstein@brightboxcharge.com>
 * License: LGPL
 * Copyright: 2015, Brightbox, Inc.
 * See_Also: http://libusbx.org
 */
module hotplug;

import core.thread;
import std.experimental.logger;
import libusb;

int main(string[] args) {
  int vendor_id  = 0xAFEF; // Change these to match a hotpluggable device on your system
  int product_id = 0x0F01; //

  libusb_context *usbctx;

  log("Initializing USB library and context");
  scope(exit) {
    log("Releasing usb context");
    libusb_exit(usbctx);
  }
  int rc = libusb_init(&usbctx);

  if (libusb_error.LIBUSB_SUCCESS == rc) {
    log("Done.");
  }
  else {
    warningf("Failed to init context: [%d] (%s), exiting...", rc, libusb_error_name(rc));
    return -1;
  }

  log("Setting debug on usb context...");
  // change to "libusb_log_level.LIBUSB_LOG_LEVEL_DEBUG" for copious output
  libusb_set_debug(usbctx, libusb_log_level.LIBUSB_LOG_LEVEL_INFO);

  log("Checking for hotplug capability...");
  rc = libusb_has_capability(libusb_capability.LIBUSB_CAP_HAS_HOTPLUG);
  if (rc != 0) {
    log("API has hotplug capability");
  }
  else {
    warningf("No hotplug support: [%d], aborting...", rc);
    return -1;
  }

  log("Registering hotplug callback...");
  libusb_hotplug_callback_handle handle;
  scope(exit) {
    log("Releasing callback handle");
    libusb_hotplug_deregister_callback(usbctx, handle);
  }

  auto event_types = (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED |
                       LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT);

  auto flags = LIBUSB_HOTPLUG_ENUM.LIBUSB_HOTPLUG_ENUMERATE;
  void  *user_data = null;

  rc = libusb_hotplug_register_callback(usbctx, event_types, flags,
                                        vendor_id, product_id, LIBUSB_HOTPLUG_MATCH_ANY,
                                        &hotplug_callback, user_data, &handle);

  if (libusb_error.LIBUSB_SUCCESS != rc) {
    log("Failed to register callback");
    return -1;
  }

  while (true) {
    rc = libusb_handle_events_completed(usbctx, null);
    if (rc != 0) {
      logf("Error %d ", rc);
      break;
    }
    Thread.sleep(dur!("seconds")(5));
  }
  
  return 0;
}


extern(C) int hotplug_callback(libusb_context *ctx, libusb_device *dev,
                               libusb_hotplug_event event, void *user_data) {
  libusb_device_handle *handle;
  libusb_device_descriptor desc;
  int rc;
  
  libusb_get_device_descriptor(dev, &desc);
  if (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED == event) {
    log("Hotplug connect event fired!");
    rc = libusb_open(dev, &handle);
    if (libusb_error.LIBUSB_SUCCESS != rc) {
      log("Could not open USB device\n");
    }
    else {
      log("Opened USB device");
    }
  }
  else if (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT == event) {
    log("Hotplug disconnect event fired!");
    if (handle) {
      log("Closing USB device");
      libusb_close(handle);
      handle = null;
    }
  }
  else {
    logf("Unhandled event %d\n", event);
  }
  return 0;
}
