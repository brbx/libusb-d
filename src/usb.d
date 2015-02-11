module usb;

import std.stdio;
import std.datetime;
import core.thread;
import std.conv;
import libusb;

ushort verbose = 1; // FIXME, zero

int main(string[] args) {
  libusb_context *usbctx;
  libusb_hotplug_callback_handle handle;

  dbgfln("Initializing USB library and context");
  int rc = libusb_init(&usbctx);

  if (libusb_error.LIBUSB_SUCCESS == rc) {
    dbgfln("Done.");
  }
  else {
    errfln("Failed to init context: [%d] (%s), exiting...", rc, libusb_error_name(rc));
    return -1;
  }

  dbgfln("Setting debug on usb context...");
  libusb_set_debug(usbctx, libusb_log_level.LIBUSB_LOG_LEVEL_DEBUG);

  rc = libusb_has_capability(libusb_capability.LIBUSB_CAP_HAS_HOTPLUG);
  if (rc != 0) {
    dbgfln("API has hotplug capability");
  }
  else {
    errfln("No hotplug support: [%d], aborting...", rc);
    goto EXIT;
  }

  rc = libusb_hotplug_register_callback(
    usbctx,
    (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED |
     LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT),
    LIBUSB_HOTPLUG_ENUM.LIBUSB_HOTPLUG_ENUMERATE, // flags
    0xafef, // vendor_id
    0x0f01, // product_id
    LIBUSB_HOTPLUG_MATCH_ANY,
    &hotplug_callback,
    null, // user data
    &handle
  );
  if (libusb_error.LIBUSB_SUCCESS != rc) {
    dbgfln("Failed to register callback");
    goto EXIT;
  }

  while (true) {
    rc = libusb_handle_events_completed(usbctx, null);
    if (rc != 0) {
      dbgfln("Error %d ", rc);
      break;
    }
    Thread.sleep(dur!("seconds")(5));
  }
  
 EXIT:
  dbgfln("Shutting down library and context...");
  libusb_exit(usbctx);
  return 0;
}


extern(C) int hotplug_callback(libusb_context *ctx, libusb_device *dev,
                               libusb_hotplug_event event, void *user_data) {
  libusb_device_handle *handle;
  libusb_device_descriptor desc;
  int rc;
  
  libusb_get_device_descriptor(dev, &desc);
  if (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED == event) {
    dbgfln("Hotplug connect event fired!");
    rc = libusb_open(dev, &handle);
    if (libusb_error.LIBUSB_SUCCESS != rc) {
      dbgfln("Could not open USB device\n");
    }
    else {
      dbgfln("Opened USB device");
    }
  }
  else if (LIBUSB_HOTPLUG_EVENTS.LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT == event) {
    dbgfln("Hotplug disconnect event fired!");
    if (handle) {
      dbgfln("Closing USB device");
      libusb_close(handle);
      handle = null;
    }
  }
  else {
    dbgfln("Unhandled event %d\n", event);
  }
  return 0;
}


void dbgfln(string func = __FUNCTION__, Args...)(string format, Args args) {
  if (verbose) {
    write(func,"() ");
    writefln(format, args);
    stdout.flush();
  }
}

void errfln(string func = __FUNCTION__, Args...)(string format, Args args) {
  stderr.writef("%28s -- %s() ", Clock.currTime().toSimpleString, func);
  stderr.writefln(format, args);
  stderr.flush();
}
