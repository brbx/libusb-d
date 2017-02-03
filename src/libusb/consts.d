/**
 * Converted/butchered LIBUSB header to a D-Language interface
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
 *
 */

module libusb.consts;

import libusb.structs : libusb_control_setup;

/** LIBUSB API Version */
const LIBUSBX_API_VERSION =  0x01000102;

const LIBUSB_DT_DEVICE_SIZE                = 18; /** Device descriptor size */
const LIBUSB_DT_CONFIG_SIZE                = 9;  /** Config descriptor size */
const LIBUSB_DT_INTERFACE_SIZE             = 9;  /** Interface descriptor size */
const LIBUSB_DT_ENDPOINT_SIZE              = 7;  /** Endpoint descriptor size */
const LIBUSB_DT_ENDPOINT_AUDIO_SIZE        = 9;  /** Audio extension descriptor size */
const LIBUSB_DT_HUB_NONVAR_SIZE            = 7;  /** Hub descriptor size */
const LIBUSB_DT_SS_ENDPOINT_COMPANION_SIZE = 6;  /** SuperSpeed (SS) Endpoint Companion descriptor size */
const LIBUSB_DT_BOS_SIZE                   = 5;  /** Binary Device Object Store (BOS) descriptor size */
const LIBUSB_DT_DEVICE_CAPABILITY_SIZE     = 3;  /** Device Capability descriptor size */

/* Binary Device Object Store (BOS) descriptor sizes */
const LIBUSB_BT_USB_2_0_EXTENSION_SIZE        =  7;  /** BOS USB 2.0 Extension descriptor size */
const LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE = 10;  /** BOS SS USB Device Capability descriptor size */
const LIBUSB_BT_CONTAINER_ID_SIZE             = 20;  /** BOS Container ID descriptor size */

/* We unwrap the BOS => define its max size */
const LIBUSB_DT_BOS_MAX_SIZE =
  ((LIBUSB_DT_BOS_SIZE)+(LIBUSB_BT_USB_2_0_EXTENSION_SIZE)
   + (LIBUSB_BT_SS_USB_DEVICE_CAPABILITY_SIZE)+(LIBUSB_BT_CONTAINER_ID_SIZE)); //* BOS max size */

const LIBUSB_ENDPOINT_ADDRESS_MASK = 0x0f;  /** Endpoint Address Mask */ /* in bEndpointAddress */
const LIBUSB_ENDPOINT_DIR_MASK     = 0x80;  /** Endpoint Direction Mask */
const LIBUSB_TRANSFER_TYPE_MASK = 0x03;     /** Transfer Type Mask */   /* in bmAttributes */
const LIBUSB_ISO_SYNC_TYPE_MASK = 0x0C;     /** ISO Sync Type Mask */
const LIBUSB_ISO_USAGE_TYPE_MASK = 0x30;    /** ISO Usage Type Mask */

const LIBUSB_CONTROL_SETUP_SIZE = libusb_control_setup.sizeof; /** Control Setup Size */

/**
 * Wildcard matching for hotplug events */
const LIBUSB_HOTPLUG_MATCH_ANY = -1; /** Hotplug "match any" wildcard */

