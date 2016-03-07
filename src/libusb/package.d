/**
 * Converted/butchered LIBUSB header to a D-Language interface
 *
 *
 * Authors: Ross Lonstein <lonstein@brightboxcharge.com>
 * License: LGPL
 * Copyright: 2015, Brightbox, Inc.
 * See_Also: http://www.libusb.org
 * Notes: Libusb itself is Copyright
 * $(UL
 *   $(LI 2001 Johannes Erdfelt <johannes@erdfelt.com>)
 *   $(LI 2007-2008 Daniel Drake <dsd@gentoo.org>)
 *   $(LI 2012 Pete Batard <pete@akeo.ie>)
 *   $(LI 2012 Nathan Hjelm <hjelmn@cs.unm.edu>) )
 * Examples:
 * ----------
 * import libusb;
 *     ...
 * libusb_context *usbctx;
 * int rc = libusb_init(&usbctx);
 * if (libusb_error.LIBUSB_SUCCESS == rc) {
 *   rc = libusb_has_capability(libusb_capability.LIBUSB_CAP_HAS_HOTPLUG);
 *     ...
 * }
 * else {
 *  // handle error
 * }
 * libusb_exit(usbctx);
 * ----------
 */

module libusb;

import std.traits;
import std.typetuple : NoDuplicates;

public {
  import consts;
  import enums;
  import structs;
  import funcs;
}

/* Total number of error codes in enum libusb_error */
const LIBUSB_ERROR_COUNT = EnumMembers!libusb_error.length;
